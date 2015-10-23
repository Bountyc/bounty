module Disputes

	def my_disputes(current_user)
		disputes = Dispute.find_by_sql("SELECT d.* FROM Disputes d JOIN bounty_hunters b ON d.bounty_hunter_id = b.id JOIN bounties ON b.bounty_id = bounties.id WHERE b.user_id = "+current_user.id.to_s+" OR bounties.poster_id = "+current_user.id.to_s+" OR d.moderator_id = "+current_user.id.to_s+" ")
	end

	def resolve_dispute(params = {})
		dispute = Dispute.find params[:dispute_id]

		#if current_user == dispute.moderator
			
			dispute.winner_user = User.find params[:winner_id]
			if dispute.winner_user == dispute.hunter
				bounty = dispute.bounty
				bounty.closed!
				dispute.bounty_hunter.approved!
				bounty.save
			else
				dispute.bounty_hunter.dispute_denied!
			end

			dispute.save
			dispute.hunter.reload_balance
		#end
	end

end
