class ChatController < ApplicationController
  before_action :authenticate_user!
  def index
  	if params[:user].nil?
  		flash[:notice] = "Sorry, something went wrong!"
  		redirect_to root_url
  	else
  		@messages = current_user.messages_with_user(params[:user])
  	end
  end
end
