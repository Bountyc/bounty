class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def see
		unseen_notifications = current_user.notifications.unseen
		unseen_notifications.each do |notification|
			notification.seen = true
			notification.save
		end
		respond_to do |format|
			format.js {render plain: ""}
		end
	end
end
