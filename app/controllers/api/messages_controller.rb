module Api
	class MessagesController < ApplicationController
		include Messages
		include ActionView::Helpers::DateHelper

		def index
			messages_json = []
			messages = get_messages(params)

			messages.each do |message|
				message_json = message.as_json
				message_json["user"] = message.user
				message_json["time_ago_in_words"] = time_ago_in_words(message.created_at)

				
				messages_json.append(message_json)
			end
			
			response = {"items" => messages_json}
			respond_to do |format|
			    format.json { render json: response}
			end
		end

		def create
			dispute = Dispute.find params[:message][:dispute_id]

			#if current_user == dispute.moderator || current_user == dispute.hunter || current_user == dispute.poster
				#params[:message][:user_id] = current_user.id #todo put this back on
				create_message(params)
				response = {"success" => true}
				respond_to do |format|
			    	format.json { render json: response}
				end
			#end
		end
	end
end
