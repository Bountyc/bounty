class Answer < ActiveRecord::Base

	# Included to create notify link
	include Rails.application.routes.url_helpers

	delegate :hunter, to: :bounty_hunter
	delegate :bounty, to: :bounty_hunter

	has_one :bounty_hunter

	validate :bounty_answer_available

	after_create :change_bounty_status
	after_create :create_notification

	scope :pending_answer, -> (id) {find_by_sql(["SELECT * from Answers a JOIN bounty_hunters b ON a.id=b.answer_id WHERE b.status=1 AND b.bounty_id=?", [id]]).first}
	
	def bounty_answer_available
		if !self.bounty.open?
			errors.add(:bounty_id, "is not valid, bounty is not open for answers")
		end
	end

	def change_bounty_status
		self.bounty.pending!
	end

	def create_notification
		notification = Notification.new
		notification.bounty_hunter = self.bounty_hunter
		notification.user = self.bounty.poster
		notification.message = self.hunter.email + " proposed a resolution to your bounty!"
		notification.action_link = bounty_path(self.bounty.id)	
		notification.new_answer! # No need for save because this saves already
	end
end