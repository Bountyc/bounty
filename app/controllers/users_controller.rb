class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show

  	@user = User.find(params[:id])
  	@solved_bounties = @user.solved_bounties

  	# Because it's just counting, no need to actualy get bounties objects, thats why not using 
  	# @user.working_on_bounties. this way is more officiant 
  	# (no need to go to bounties table -- like function does)
  	@working_on_bounties_count = @user.bounty_hunters.where(status: 0).count

  	@resolutions_count = @user.answers.count
  end
end
