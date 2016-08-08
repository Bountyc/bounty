class Bounty < ActiveRecord::Base
	
	acts_as_taggable
	has_many :bounty_hunters
	has_many :hunters, through: :bounty_hunters
	has_many :views

	has_many :answers, through: :bounty_hunters, source: :answer
	belongs_to :poster, :class_name => "User", :foreign_key => "poster_id"
	
	enum status: [:open, :pending, :closed]

	after_create :update_user_balance
	after_update :update_user_balance, :if => :price_changed?
 

	validates_presence_of [:price, :title, :description, :poster_id]
	validates :price, :numericality => { :greater_than => 0}

	validate :poster_can_afford, :on => :create

	scope :search, -> (field, text) { where("lower(#{field}) LIKE ?", "%#{text.downcase}%") }
	scope :open_bounties, -> { where(status: 0) }

	default_scope {order('created_at DESC')}

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

	# SEO
	def slug
    name.downcase.gsub(" ", "-")  
  	end

  	def to_param
   		"#{id}-#{slug}"
  	end

	private
		def update_user_balance
			self.poster.reload
			self.poster.reload_balance
		end

		def poster_can_afford
			if errors.blank? # If other validations didn't pass, this function will break code
				self.poster.reload_balance
				if self.poster.balance - self.price < 0.0
					errors.add(:price, "is not affordable")
				end
			end
		end
end
