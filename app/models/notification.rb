class Notification < ActiveRecord::Base
	include HtmlGenerator
	belongs_to :bounty_hunter
	belongs_to :user
	after_create :push_notification

	validates_presence_of [:message]

	enum notification_type: [:answer_denied, :answer_accepted, :new_answer]

	def push_notification
		Pusher.app_id = PUSHER_APP_ID
		Pusher.key = PUSHER_KEY
		Pusher.secret = PUSHER_SECRET

		Pusher["private-user-#{self.user_id}"].trigger('new-notification', notification_html(self.message, Time.now))
		#Pusher["private-user-1"].trigger('new-notification', 'hi')
	end
end
