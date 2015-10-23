module Messages
	def get_messages(params = {})
		dispute = Dispute.find params[:dispute_id]
		messages = dispute.messages
		return messages
	end

	def create_message(params = {})
		message = Message.new(message_params)
		message.save
	end

	private
        def message_params
            params.require(:message).permit(:contents, :dispute_id, :user_id)
        end
end