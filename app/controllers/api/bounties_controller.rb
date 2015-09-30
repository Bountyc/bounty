module Api
	class BountiesController < ApplicationController
		include Bounties

		def index
			bounties = get_bounties(params)
			respond_to do |format|
			    format.json { render json: bounties}
			end
		end
	end
end