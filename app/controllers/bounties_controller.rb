class BountiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :define_user


  def index
    if params[:search_text]
      @open_bounties = Bounty.search("title",params[:search_text]).where(:status => 0).limit(10)
      @open_bounties_count =Bounty.search("title",params[:search_text]).where(:status => 0).count

      @resolved_bounties = Bounty.search("title",params[:search_text]).where(:status => 2).limit(10)
      @resolved_bounties_count = Bounty.search("title",params[:search_text]).where(:status => 2).count

      if current_user
        @my_bounties = Bounty.search("title",params[:search_text]).where("poster_id = " + current_user.id.to_s).limit(10)
        @my_bounties_count = Bounty.search("title",params[:search_text]).where("poster_id = " + current_user.id.to_s).count
      end
    else
      @open_bounties = Bounty.where(:status => 0).limit(10)
      @open_bounties_count =Bounty.where(:status => 0).count

      @resolved_bounties = Bounty.where(:status => 2).limit(10)
      @resolved_bounties_count = Bounty.where(:status => 2).count
      
      if current_user
        @my_bounties = current_user.bounties.limit(10)
        @my_bounties_count = current_user.bounties.count
      end
    end

  end

  def show
  	set_bounty
  	if @bounty.poster == current_user
  		@user_role = :poster
  	elsif current_user
  		if @bounty.hunters.include? current_user
  			@bounty_hunter_relation_object = @bounty.bounty_hunters.find_by_user_id(current_user)

  			@user_role = @bounty_hunter_relation_object.status.to_sym
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

    if current_user
      if !current_user.views.exists?(bounty_id: @bounty.id)
        view = View.new
        view.user = current_user
        view.bounty = @bounty
        view.save
      end
    end

    @working_bounty_hunters = @bounty.working_bounty_hunters
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

    bh = BountyHunter.new
    bh.hunter = current_user
    bh.bounty = @bounty
    bh.started_working_at = Time.now
    if bh.save
      notification = Notification.new
      notification.bounty_hunter = bh
      notification.user = @bounty.poster
      notification.message = current_user.email + " started working on your bounty!"
      notification.action_link = bounty_path(@bounty.id)
      notification.started_working!
      notification.save
    end

  	redirect_to @bounty
  end
  

  private

	  # Use callbacks to share common setup or constraints between actions.
	  def set_bounty
	    @bounty = Bounty.find(params[:id])
	  end

	  # Never trust parameters from the scary internet, only allow the white list through.
	  def bounty_params
		 params.require(:bounty).permit(:title, :description, :price, :tag_list)
	  end
end
