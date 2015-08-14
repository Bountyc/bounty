module Transfer
	class PaymentsController < ApplicationController
		before_action :authenticate_user!, except: [:index, :show]
		before_action :define_user

		def new
			price = params[:price]
			@paypal_payment = PayPal::SDK::REST::Payment.new({
	  			:intent => "sale",
	  			:payer => {
	    		:payment_method => "paypal" },
	  			:redirect_urls => {
	    		:return_url => root_url + transfer_payments_path,
	    		:cancel_url => "https://devtools-paypal.com/guide/pay_paypal/ruby?cancel=true" },
	  			:transactions => [ {
	    			:amount => {
	     			:total => price,
	      			:currency => "USD" },
	    			:description => "Bounty Balance" 
	    			} ] 
	    			 
	    		})
			@paypal_payment.create
			
			index = @paypal_payment.links.find_index {|item| item.rel == "approval_url"}
			link = @paypal_payment.links[index]
			redirect_to link.href
		end 

		def create
			payment = Payment.new
			payment.payment_id = params[:paymentId]
			payment.payer_id = params[:PayerID]
			payment.user = current_user
			
			@paypal_payment_execute = PayPal::SDK::REST::Payment.new({
  				:id => payment.payment_id})

			@paypal_payment_execute.execute( :payer_id => payment.payer_id  )

			payment.amount = @paypal_payment_execute.transactions[0].amount.total
			payment.save
			byebug
			current_user.balance += payment.amount 
			current_user.save
			render :plain => "successfully added " + payment.amount + " to "+current_user.id + "'s account"
		end


	end
end