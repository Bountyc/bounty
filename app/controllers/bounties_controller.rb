class BountiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :define_user


  def index
  	@bounties = Bounty.all
  end

  def show
  	set_bounty
  	if @bounty.poster == current_user
  		@user_role = :poster
  	elsif current_user
  		if @bounty.hunters.include? current_user
  			bounty_hunter_relation_object = @bounty.bounty_hunters.find_by_user_id(current_user)

  			@user_role = bounty_hunter_relation_object.status.to_sym
  		else
  			@user_role = :hunter
  		end
  	else
  		@user_role = :guest
  	end

  	@answer = Answer.new

  	if @bounty.pending?
  		@suggested_answer = Answer.pending_answer(@bounty.id)
  	end

    if !current_user.views.any?{|v| v.bounty == @bounty}
      view = View.new
      view.user = current_user
      view.bounty = @bounty
      view.save
    end
  end

  def new
  	@bounty = Bounty.new
  end

  def create
  	@bounty = Bounty.new(bounty_params)
  	@bounty.poster = current_user
  	if @bounty.save
		redirect_to @bounty, notice: 'Bounty was successfully created.'
    else
        render :new
    end
  end

  def add_working_user
  	@bounty = Bounty.find(params[:id])

  	@bounty.hunters << current_user

  	redirect_to @bounty
  end
  

  private

	  # Use callbacks to share common setup or constraints between actions.
	  def set_bounty
	    @bounty = Bounty.find(params[:id])
	  end

	  # Never trust parameters from the scary internet, only allow the white list through.
	  def bounty_params
		 params.require(:bounty).permit(:title, :description, :price)
	  end
end
