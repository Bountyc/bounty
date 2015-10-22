class AnswersController < ApplicationController
	before_action :authenticate_user!
	def create
		@answer = Answer.new(answer_params)
		bounty = Bounty.find params[:bounty_id]
		bh = bounty.bounty_hunters.find_by_user_id(current_user)
		if !bh
			bh = BountyHunter.new
			bh.hunter = current_user
			bh.bounty = bounty
		end
		
		bh.answer = @answer
		@answer.bounty_hunter = bh
		@answer.save
		bh.pending!
		bounty.pending!
		bh.save
		bounty.save

		redirect_to :back
	end

	def approve
		answer = Answer.find params[:id]
		
		#make sure user owns the bounty related to this question
		if current_user.bounties.include? answer.bounty
			answer.bounty.closed!
			answer.bounty_hunter.approved!

			# answer.user.reload_balance
			# current_user.reload_balance

			answer.save

			notification = Notification.new
			notification.bounty_hunter = answer.bounty_hunter
			notification.user = answer.hunter
			notification.message = "just accepted your answer to " + notification.bounty_hunter.bounty.title + "!"
			notification.action_link = bounty_path(answer.bounty.id)
			notification.answer_accepted!
			notification.save

			answer.hunter.reload_balance
		else
			flash[:error] = "You are not allowed to deny!"
			redirect_to root_url
		end

		redirect_to :back
	end

	def deny
		answer = Answer.find params[:id]
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
			notification.user = answer.hunter
			notification.message = "denied your answer to "+notification.bounty_hunter.bounty.title + ". Click to view the denial reason."
			notification.action_link = bounty_path(answer.bounty.id)			
			notification.answer_denied!
			notification.save
		else
			flash[:error] = "You are not allowed to deny!"
			redirect_to root_url
		end

		redirect_to :back
	end

	private

	  def answer_params
		 params.require(:answer).permit(:description, :bounty_id)
	  end
end
