class ChatController < ApplicationController
  before_action :authenticate_user!
  def index
  	if params[:user].nil? or params[:user] == current_user.id.to_s
  		flash[:notice] = "Sorry, something went wrong!"
  		redirect_to root_url
  	else
  		@messages = current_user.messages_with_user(params[:user]).last(25)
  		@chat_partner = User.find(params[:user])
      @react_form = {
        :action => send_message_chat_index_path(user: @chat_partner.id),
        :csrf_param => request_forgery_protection_token,
        :csrf_token => form_authenticity_token
      }
  		respond_to do |format|
		    format.html
			  format.json { render json: @messages.to_json }
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
