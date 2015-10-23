module Api
	class DisputesController < ApplicationController
		include Disputes
		include ActionView::Helpers::DateHelper

		def resolve
			resolve_dispute(params)
			response = {"success" => true}
				respond_to do |format|
			    	format.json { render json: response}
				end
		end
	end
end