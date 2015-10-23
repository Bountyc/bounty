class ChatController < ApplicationController
  before_action :authenticate_user!
  def index
  	if params[:user].nil?
  		flash[:notice] = "Sorry, something went wrong!"
  		redirect_to root_url
  	else
  		@messages = current_user.messages_with_user(params[:user])
  		@chat_partner = User.find(params[:user])
  		respond_to do |format|
		    format.html
			  format.json { render json: @messages }
		  end
  	end
  end

  def send_message
    message = BountyMessage.new
    message.message = params[:message]
    message.sender = current_user
    message.receiver_id = params[:user]
    message.save
    render :nothing => true
  end
end
