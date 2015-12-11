class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @new_users = User.order("created_at DESC").limit(16)
    @by_name_users = User.order("lower(first_name) ASC").limit(16)
    @popular_users = User.order("reputation DESC").limit(16)
  end

  def show

  	set_user
  	@solved_bounties = @user.solved_bounties

  	# Because it's just counting, no need to actualy get bounties objects, thats why not using 
  	# @user.working_on_bounties. this way is more officiant 
  	# (no need to go to bounties table -- like function does)
  	@working_on_bounties_count = @user.bounty_hunters.where(status: 0).count

  	@resolutions_count = @user.answers.count
  end

  def edit
    set_user

    if current_user != @user
      flash[:error] = "Sorry, but you can't edit this user"
      redirect_to root_url
    else
      @solved_bounties = @user.solved_bounties

      # Because it's just counting, no need to actualy get bounties objects, thats why not using 
      # @user.working_on_bounties. this way is more officiant 
      # (no need to go to bounties table -- like function does)
      @working_on_bounties_count = @user.bounty_hunters.where(status: 0).count

      @resolutions_count = @user.answers.count      
    end

  end

  def update
    set_user
    if current_user == @user
      if @user.update_attributes(user_params)
          redirect_to @user
      else
          render 'edit';
      end
    else
      flash[:error] = "Sorry, something went wrong"
      redirect_to root_url
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
     params.require(:user).permit(:first_name, :last_name, :description)
    end
end
