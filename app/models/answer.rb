class Answer < ActiveRecord::Base
	delegate :hunter, to: :bounty_hunter
	delegate :bounty, to: :bounty_hunter

	has_one :bounty_hunter

	validate :bounty_answer_available

	after_create :change_bounty_status

	validates :user_id, presence: true

	scope :pending_answer, -> (id) {find_by_sql(["SELECT * from Answers a JOIN bounty_hunters b ON a.id=b.answer_id WHERE b.status=1 AND b.bounty_id=?", [id]]).first}
	def bounty_answer_available
	  if !self.bounty.open?
        errors.add(:bounty_id, "is not valid, bounty is not open for answers")
      end
	end

	def change_bounty_status
		self.bounty.pending!
	end
end