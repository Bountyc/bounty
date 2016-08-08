class UserNotifier < ApplicationMailer

	def notify_users_bounty_email(bounty)
		@bounty = bounty
		users = []
		@bounty.tags.each do |t|
			tag_users = User.tagged_with t
			tag_users.each do |u|
				unless users.include?(u)
					users << u
				end
			end
		end

		emails = []
		users.each do |u|
			emails << u.email
		end
		puts emails
		mail( :to => emails,
			:subject => 'Bounty Posted!')

	end

end