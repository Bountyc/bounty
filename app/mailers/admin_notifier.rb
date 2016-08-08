class AdminNotifier < ApplicationMailer

	def withdraw_money_admin_email(user, withdrawal, email)
		@user = user
		@withdrawal = withdrawal
		@email = email

		@user = user
		@withdrawal = withdrawal
		@host = AdminNotifier.default_url_options[:host]

		mail( :to => ["dkgs1998@gmail.com", "maor.kern@gmail.com"],
			:subject => 'Someone has asked to withdraw money!' )
	end

end