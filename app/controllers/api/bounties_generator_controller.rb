module Api
	class BountiesGeneratorController < ApplicationController
		include BountiesGenerator

		def create
			if params[:access_token] == "stackit"
				users = JSON.parse params[:users]

				BountiesGenerator.generate_bounties_for_users(users)

				render :json=>"{\"status\":\"success\"}"
			else
				render :json=>"{\"error\":\"enter the api token\"}"
			end


		end
	end
end