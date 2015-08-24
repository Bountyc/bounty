class TagsController < ApplicationController
	def index
		@tags = Tag.all
		render json: Tag.where('name like ?', "%#{params[:q]}%").map {|tag| {id: tag.name}}
	end
end
