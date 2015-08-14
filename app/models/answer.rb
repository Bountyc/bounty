class Answer < ActiveRecord::Base
	belongs_to :bounty
	belongs_to :user
	validate :bounty_answer_available

	after_create :change_bounty_status

	scope :pending_message, -> (id) {find_by_sql(["SELECT * from Answers a JOIN bounty_hunters b ON a.user_id=b.user_id WHERE b.status=1 AND b.bounty_id=?", [id]]).first}
	def bounty_answer_available
	  if !self.bounty.open?
        errors.add(:bounty_id, "is not valid, bounty is not open for answers")
      end
	end

	def change_bounty_status
		self.bounty.pending!
	end
	#SELECT answer_id FROM answers a JOIN bounty_hunters b ON a.user_id = b.user_id WHERE b.status = 1 AND b.bounty_id = 2
end