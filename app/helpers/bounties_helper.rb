module BountiesHelper
	def load_highest_paying_bounties
		@highest_paying_bounties = Bounty.limit(10).order("price desc")
	end

	def load_highest_viewed_bounties
		@highest_viewed_bounties = Bounty.select("bounties.*, COUNT(views.id) view_count").joins(:views).group("bounties.id").order("view_count DESC")
	end

	def time_differance_string(timediff)
		secs  = timediff.to_int
	    mins  = secs / 60
	    hours = mins / 60
	    days  = hours / 24

	    if days > 0
	      "#{days} days and #{hours % 24} hours"
	    elsif hours > 0
	      "#{hours} hours and #{mins % 60} minutes"
	    elsif mins > 0
	      "#{mins} minutes"
	    elsif secs >= 0
	      "#a few seconds"
	    end
	end
end
