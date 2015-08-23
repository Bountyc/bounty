module NotificationsHelper
	include HtmlGenerator #includes functen's taken from there

	def load_notifications
  		if current_user
  			@notifications = current_user.notifications.limit 5
  			@unseen_notifications_count = current_user.notifications.unseen.count
  		end
  	end
end
