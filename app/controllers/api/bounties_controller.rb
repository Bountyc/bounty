module Api
	class BountiesController < ApplicationController
		include Bounties
		include ActionView::Helpers::DateHelper

		def index
			bounties_json = []
			bounties = get_bounties(params)

			bounties.each do |bounty|
				bounty_json = bounty.as_json

				bounty_json["link"] = bounty_path(bounty)
				bounty_json["working_users_count"] = bounty.working_users.count
				bounty_json["views"] = bounty.views.count
				bounty_json["poster"] = bounty.poster
				bounty_json["time_ago_in_words"] = time_ago_in_words(bounty.created_at)

				bounty_json["tags"] = bounty.tags.pluck(:name)
				bounties_json.append(bounty_json)
			end

			has_more = false

			if nil != params[:offset] and nil != params[:limit]
				if count_bounties(params) - params[:offset].to_i - params[:limit].to_i > 0
					has_more = true
				end
			end
			
			response = {"items" => bounties_json, "has_more" => has_more}
			respond_to do |format|
			    format.json { render json: response}
			end
		end
	end
end