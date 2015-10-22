module Bounties
	def get_bounties(params = {})
		bounties = Bounty.all

		unless nil == params[:status]
			bounties =  Bounty.where(:status => params[:status])
		end

		unless nil == params[:search]
			bounties = bounties.search("title", params[:search])
		end

		unless nil == params[:user_id]
			bounties = bounties.where(poster_id: params[:user_id])
		end

		# Make limit and offset if they aren't set already
		limit = params[:limit] || 10
		offset = params[:offset] || 0

		bounties = bounties.limit(limit).offset(offset)

		return bounties
	end

	def count_bounties(params = {})
		bounties = Bounty.all

		unless nil == params[:status]
			bounties = bounties.where(:status => params[:status])
		end

		unless nil == params[:search]
			bounties = bounties.search("title", params[:search])
		end

		unless nil == params[:user_id]
			bounties = bounties.where(poster_id: params[:user_id])
		end

		return bounties.count
	end

end
