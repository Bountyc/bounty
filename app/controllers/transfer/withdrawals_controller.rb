module Transfer
	class WithdrawalsController < ApplicationController
		before_action :authenticate_user!, except: [:index, :show]
		before_action :define_user

		def create
			current_user.reload_balance

			withdrawal = Withdrawal.new(withdrawal_params)

			withdrawal.user = current_user

			#Check that user has enough money in his account to make this withdrawal
			if (current_user.balance - withdrawal.amount) < 0
				logger.info "User tried to withdraw more then he has in his balance"
				flash[:error] = "Don't. Just don't. You seriously thought that would work? Well fuck you cause I'm smarter then you and I fucked your mom so stfu. You have been charged a $12 penalty for being a penis."
				redirect_to root_url
				return
			end

			@payout = PayPal::SDK::REST::Payout.new(
			  {
				:sender_batch_header => {
				  :sender_batch_id => SecureRandom.hex(8),
				  :email_subject => 'Withdrawal from Bounty',
				},
				:items => [
				  {
					:recipient_type => 'EMAIL',
					:amount => {
					  :value => withdrawal.amount,
					  :currency => 'USD'
					},
					:note => 'Bounty loves you!',
					:receiver => current_user.email,
					:sender_item_id => "0",
				  }
				]
			  }
			)

			begin
			  @payout_batch = @payout.create
			  withdrawal.payout_batch_id = @payout_batch.batch_header.payout_batch_id
			  withdrawal.save

			  current_user.balance -= withdrawal.amount
			  current_user.save

			  logger.info "Created Payout with [#{@payout_batch.batch_header.payout_batch_id}]"
			rescue ResourceNotFound => err
			  logger.error @payout.error.inspect
			end
			redirect_to user_path(current_user.id)
			#render :plain => "Yey! $" + withdrawal.amount.to_s + " withdrawn"
		end

		
		private


			  # Never trust parameters from the scary internet, only allow the white list through.
			  def withdrawal_params
				 params.require(:withdrawal).permit(:amount)
			  end

		end
end