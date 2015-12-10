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
				flash[:error] = "You can't withdraw more money than you have in your accounts balance"
				redirect_to root_url
				return
			end
			# logger.info "Configuring PayPal"
			# PayPal::SDK.configure({
  	# 			:mode => "live",
  	# 			:client_id => "ARwIMWY6CSmzq2sORTyuLCWGjKi4OZyhuRG-5Gc0_RK2zhUhPFEOAi3W7IetP2AdNVhDMw98B-3YVoFC",
  	# 			:client_secret => "ECP5MW_w6GiCGYqth52Gw732e4j8K4gFfD-bGOZImFWFcJcmXWvpTBgCgF46Ormg-03YXkVX1Cz5QP84"
			# })
			# @payout = PayPal::SDK::REST::Payout.new(
			#   {
			# 	:sender_batch_header => {
			# 	  :sender_batch_id => SecureRandom.hex(8),
			# 	  :email_subject => 'Withdrawal from Bounty',
			# 	},
			# 	:items => [
			# 	  {
			# 		:recipient_type => 'EMAIL',
			# 		:amount => {
			# 		  :value => withdrawal.amount- withdrawal.amount*0.1,
			# 		  :currency => 'USD'
			# 		},
			# 		:note => 'Bounty loves you!',
			# 		:receiver => current_user.email,
			# 		:sender_item_id => "0",
			# 	  }
			# 	]
			#   }
			# )

			# #begin
			# @payout_batch = @payout.create
			# withdrawal.payout_batch_id = @payout_batch.batch_header.payout_batch_id
			# withdrawal.save

			# current_user.balance -= withdrawal.amount
			# current_user.save

			# logger.info "Created Payout with [#{@payout_batch.batch_header.payout_batch_id}]"
			# #rescue
			# #	logger.info "JESUS FUCK CHRIST ERROR OMG ERROR ONWUBUWIDBWYBIWBY OGOWIWHHWHWUEHU"

			# #	logger.error @payout.error.inspect
			# #end

			if withdrawal.save
				a = AdminNotifier.withdraw_money_admin_email(withdrawal.user, withdrawal).deliver

				current_user.reload # In order to know about the new withdrawal
				current_user.reload_balance

				flash[:notice] = "A message was sent to admin, withdrawal will be proccesed in the next 24 hours!"
			else
				flash[:error] = "Sorry, something went wrong!"
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
