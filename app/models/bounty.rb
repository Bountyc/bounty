class Bounty < ActiveRecord::Base
	acts_as_taggable
	has_many :bounty_hunters
	has_many :hunters, through: :bounty_hunters
	has_many :views

	has_many :answers, through: :bounty_hunters, source: :answer
	belongs_to :poster, :class_name => "User", :foreign_key => "poster_id"
	
	enum status: [:open, :pending, :closed]

	after_create :change_user_balance

	validates_presence_of [:price, :title, :description]
	validates :price, :numericality => { :greater_than => 0}

	validate :poster_can_afford

	scope :search, -> (field, text) { where("#{field} LIKE ?", "%#{text}%") }
	default_scope {order('updated_at DESC')}
	def working_users
		return User.joins(:bounty_hunters).where("bounty_hunters.status = 0").where("bounty_hunters.bounty_id = ?", [self.id])
	end

	def working_bounty_hunters
		return self.bounty_hunters.where(status: 0)
	end

	def pending_answer
		bh = self.bounty_hunters.find_by_status(1)
		if bh.nil?
			return nil
		else
			return bh.answer
		end
	end

	def approved_answer
		bh = self.bounty_hunters.find_by_status(3)
		if bh.nil?
			return nil
		else
			return bh.answer
		end
	end

	private
		def change_user_balance
			poster = self.poster
			poster.balance -= self.price
			poster.save
		end

		def poster_can_afford
			self.poster.reload_balance
			if self.poster.balance - self.price < 0.0
				errors.add(:price, "is not affordable")
			end
		end
end
