module BountiesHelper
	def load_highest_paying_bounties
		# Using reorder because in model defined default scope to order by updated_at
		@highest_paying_bounties = Bounty.open_bounties.limit(10).reorder("price DESC")
	end

	def load_highest_viewed_bounties
		# Using reorder because in model defined default scope to order by updated_at
		@highest_viewed_bounties = Bounty.open_bounties.limit(10).select("bounties.*, COUNT(views.id) view_count").joins(:views).group("bounties.id").reorder("view_count DESC")
	end

	def share_link(network, url)
		case network
		when :facebook
			return 'https://www.facebook.com/sharer/sharer.php?u=' + Rack::Utils.escape(url)
		when :twitter
			return 'https://twitter.com/home?status=' + Rack::Utils.escape(url)
		when :google_plus
			return 'https://plus.google.com/share?url=' + Rack::Utils.escape(url)
		when :linkedin
			return 'https://www.linkedin.com/shareArticle?mini=true&url=' + Rack::Utils.escape(url) + '&title=&summary=&source='
		when :email
			return 'mailto:?&subject=A interesting bounty&body=Hey!%0ACome%20look%20at%20this%20awesome%20bounty%3A%0A' + Rack::Utils.escape(url)
		end
	end

end
