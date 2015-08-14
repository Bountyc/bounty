class Answer < ActiveRecord::Base
	belongs_to :bounty
	belongs_to :user
	validate :bounty_answer_available

	after_create :change_bounty_status
	def bounty_answer_available
	  if !self.bounty.open?
        errors.add(:bounty_id, "is not valid, bounty is not open for answers")
      end
	end

	def change_bounty_status
		self.bounty.pending!
	end
end