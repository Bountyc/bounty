class UserNotifier < ApplicationMailer

	def accept_answer(bounty, resolver)

	@poster = bounty.poster
	@resolver = resolver
	@bounty = bounty

	mail( :to => resolver.email,
		:subject => 'Someone has accepted your answer!' )
	end

end