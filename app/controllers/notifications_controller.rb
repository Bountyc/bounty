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

	def show
		notification = Notification.find(params[:id])
		notification.clicked = true
		notification.save
		redirect_to notification.action_link
	end
end
