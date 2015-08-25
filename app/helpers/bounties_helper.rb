module BountiesHelper
	def load_highest_paying_bounties
		# Using reorder because in model defined default scope to order by updated_at
		@highest_paying_bounties = Bounty.open_bounties.limit(10).reorder("price DESC")
	end

	def load_highest_viewed_bounties
		# Using reorder because in model defined default scope to order by updated_at
		@highest_viewed_bounties = Bounty.open_bounties.limit(10).select("bounties.*, COUNT(views.id) view_count").joins(:views).group("bounties.id").reorder("view_count DESC")
	end

end
