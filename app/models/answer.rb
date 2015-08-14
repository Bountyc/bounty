class Answer < ActiveRecord::Base
	belongs_to :bounty
	belongs_to :user
	validate :bounty_answer_available

	def bounty_answer_available
	  if !self.bounty.open?
        errors.add(:bounty_id, "is not valid, bounty is not open for answers")
      end
	end
end