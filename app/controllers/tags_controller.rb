class TagsController < ApplicationController
	before_action :authenticate_user!
	def index
		@tags = Tag.all
		respond_to do |format|
		    format.html
		    format.json { render json: Tag.where('name like ?', "%#{params[:q]}%").map {|tag| {id: tag.name}} }
		  end
	end
end