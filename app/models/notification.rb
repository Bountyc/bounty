class Notification < ActiveRecord::Base
	include HtmlGenerator
	belongs_to :bounty_hunter
	belongs_to :user
	after_create :push_notification

	validates_presence_of [:message]

	enum notification_type: [:answer_denied, :answer_accepted, :new_answer, :started_working]

	scope :unseen, -> { where(seen: false) }
	default_scope {order('updated_at DESC')}

	def push_notification
		Pusher.app_id = PUSHER_APP_ID
		Pusher.key = PUSHER_KEY
		Pusher.secret = PUSHER_SECRET

		Pusher["private-user-#{self.user_id}"].trigger('new-notification', notification_html(self.message, Time.now, false))
	end
end
