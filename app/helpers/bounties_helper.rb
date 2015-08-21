module BountiesHelper
	def load_highest_paying_bounties
		@highest_paying_bounties = Bounty.limit(10).order("price desc")
	end

	def load_highest_viewed_bounties
		@highest_viewed_bounties = Bounty.select("bounties.*, COUNT(views.id) view_count").joins(:views).group("bounties.id").limit(10).order("view_count DESC")
	end

end
