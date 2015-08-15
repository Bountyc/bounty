class AnswersController < ApplicationController
	def create
		@answer = Answer.new(answer_params)
		@answer.user = current_user
		@answer.bounty = bounty
		@answer.save
		redirect_to :back
	end

	def approve_answer
		answer = Answer.find params[:answer_id]
		
		#make sure user owns the bounty related to this question
		if current_user.bounties.include? answer.bounty
			answer.bounty.closed!
			answer.bounty_hunter.approved!

			answer.user.reload_balance
			current_user.reload_balance

			answer.save

			notification = Notification.new
			notification.bounty_hunter = answer.bounty_hunter
			notification.user = current_user
			notification.answer_accepted!
			notification.message = "just accepted your answer to "+notification.bounty_hunter.bounty.title +"!"
			notification.save
		end
	end

	def deny_answer
		answer = Answer.find params[:answer_id]
		denial_reason = params[:denial_reason]

		#make sure user owns the bounty related to this question
		if current_user.bounties.include? answer.bounty

			answer.bounty.open!
			answer.bounty_hunter.denied!

			answer.denial_reason = denial_reason
			answer.save

			#TODO add notification to denied user
			notification = Notification.new
			notification.bounty_hunter = answer.bounty_hunter
			notification.user = current_user
			notification.answer_denied!
			notification.message = "denied your answer to "+notification.bounty_hunter.bounty.title + ". Click to view the denial reason."
			notification.save

		end
	end

	private

	  def answer_params
		 params.require(:answer).permit(:description, :bounty_id)
	  end
end
