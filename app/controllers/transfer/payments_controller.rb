module Transfer
	class PaymentsController < ApplicationController
		before_action :authenticate_user!, except: [:index, :show]
		before_action :define_user

		def start_payment
			@payment = Payment.new(payment_params)
			PayPal::SDK.configure({
  				:mode => "live",
  				:client_id => "ARwIMWY6CSmzq2sORTyuLCWGjKi4OZyhuRG-5Gc0_RK2zhUhPFEOAi3W7IetP2AdNVhDMw98B-3YVoFC",
  				:client_secret => "ECP5MW_w6GiCGYqth52Gw732e4j8K4gFfD-bGOZImFWFcJcmXWvpTBgCgF46Ormg-03YXkVX1Cz5QP84"
			})
			@paypal_payment = PayPal::SDK::REST::Payment.new({
	  			:intent => "sale",
	  			:payer => {
	    		:payment_method => "paypal" },
	  			:redirect_urls => {
	    		:return_url => root_url + transfer_payments_path,
	    		:cancel_url => "https://devtools-paypal.com/guide/pay_paypal/ruby?cancel=true" },
	  			:transactions => [ {
	    			:amount => {
	     			:total => sprintf('%.2f', @payment.amount),
	      			:currency => "USD" 
	      			},
	    			:description => "Bounty Balance" 
	    			} ]    			 
	    		})
			@paypal_payment.create
			
			index = @paypal_payment.links.find_index {|item| item.rel == "approval_url"}
			link = @paypal_payment.links[index]
			#render :text => @paypal_payment
			#redirect_to link.href
		end 

		def create
			payment = Payment.new
			payment.payment_id = params[:paymentId]
			payment.payer_id = params[:PayerID]
			payment.user = current_user
			
			@paypal_payment_execute = PayPal::SDK::REST::Payment.new({
  				:id => payment.payment_id})

			@paypal_payment_execute.execute( :payer_id => payment.payer_id  )
			if @paypal_payment_execute.transactions[0].amount.total == nil
				render :plain => "Sorry, something went wrong"
				return
			end
			payment.amount = @paypal_payment_execute.transactions[0].amount.total
			payment.save
			current_user.reload_balance
			redirect_to user_path(current_user.id)
		end


		  private


			  def payment_params
				 params.require(:payment).permit(:amount)
			  end

			end
end