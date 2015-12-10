class AdminNotifier < ApplicationMailer

	def withdraw_money_admin_email(user, withdrawal)

	@user = user
	@withdrawal = withdrawal

	mail( :to => ["dkgs1998@gmail.com", "maor.kern@gmail.com"],
		:subject => 'Someone has asked to withdraw money!' )
	end

end