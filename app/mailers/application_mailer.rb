class ApplicationMailer < ActionMailer::Base
	default :from => 'admin@bountyc.com'
	layout 'mailer'
end
