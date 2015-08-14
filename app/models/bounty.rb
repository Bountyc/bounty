class Bounty < ActiveRecord::Base
	
	has_many :bounty_hunters
	has_many :hunters, through: :bounty_hunters
	has_and_belongs_to_many :tags

	has_many :answers
	belongs_to :poster, :class_name => "User", :foreign_key => "poster_id"
	
	enum status: [:open, :pending, :closed]

	after_create :change_user_balance

	validates :price, presence: true
	validate :poster_can_afford

	private
		def change_user_balance
			poster = self.poster
			poster.balance -= self.price
			poster.save
		end

		def poster_can_afford
			if self.poster.balance - self.price < 0.0
				errors.add(:price, "is not affordable")
			end
		end
end
