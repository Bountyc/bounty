module NotificationsHelper
	def load_notifications
  		if current_user
  			@notifications = current_user.notifications.limit 5
  			@total_notification_count = current_user.notifications.count
  		end
  	end
end
