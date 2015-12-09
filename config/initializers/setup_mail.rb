ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:address			=>	'smtp.sendgrid.net',
	:port				=>	'587',
	:authentication		=>	:plain,
	:user_name			=>	'app40094660@heroku.com',
	:password			=>	'pwakiyih1205',
	:domain				=>	'bountyc.com',
	:enable_starttls_auto => true
}