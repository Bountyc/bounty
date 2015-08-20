class Notification < ActiveRecord::Base
	belongs_to :bounty_hunter
	belongs_to :user
	enum notification_type: [:answer_denied, :answer_accepted, :new_answer]
	after_save :notify

	def notify
		sync_update self.user
	end
end
