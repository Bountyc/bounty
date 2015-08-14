class AnswersController < ApplicationController
	def create
		@answer = Answer.new(answer_params)
		@answer.user = current_user
		if @answer.save
			# Do something
		end
		redirect_to :back
	end

	private

	  def answer_params
		 params.require(:answer).permit(:description, :bounty_id)
	  end
end
