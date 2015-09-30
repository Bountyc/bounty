class BountiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :define_user


  def index
      @open_bounties = Bounty.where(:status => 0).limit(10)
      @open_bounties_count =Bounty.where(:status => 0).count

      @resolved_bounties = Bounty.where(:status => 2).limit(10)
      @resolved_bounties_count = Bounty.where(:status => 2).count

      if current_user
        @my_bounties = current_user.bounties.limit(10)
        @my_bounties_count = current_user.bounties.count
      end

    if params[:search_text]
      @open_bounties = @open_bounties.search("title",params[:search_text])
      @open_bounties_count =@open_bounties.search("title",params[:search_text])

      @resolved_bounties = @resolved_bounties.search("title",params[:search_text])
      @resolved_bounties_count = @resolved_bounties_count.search("title",params[:search_text])

      if current_user
        @my_bounties = @my_bounties.search("title",params[:search_text])
        @my_bounties_count = @my_bounties_count.search("title",params[:search_text])
      end
    elsif params[:from] or params[:to]
      x = 0
    end
    render layout: "homepage"

  end

  def show
  	set_bounty
    if @bounty.nil?
      flash[:error] = "Sorry, something went wrong"
      redirect_to root_url
    else
    	if @bounty.poster == current_user
    		@user_role = :poster
    	elsif user_signed_in?
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

      if user_signed_in?
        if !current_user.views.exists?(bounty_id: @bounty.id)
          view = View.new
          view.user = current_user
          view.bounty = @bounty
          view.save
        end
      end

      @working_bounty_hunters = @bounty.working_bounty_hunters
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

  def edit
    if user_signed_in?
      set_bounty
      if @bounty.nil? or current_user != @bounty.poster
        flash[:error] = "Sorry, something went wrong"
        redirect_to root_url
      end
    else
      redirect_to new_user_session_path
    end
  end

  def update
    set_bounty
    if @bounty.nil?
      flash[:error] = "Sorry, something went wrong"
      redirect_to root_url
    else    
      if @bounty.update_attributes(bounty_params)
        redirect_to @bounty
      else
        render 'edit';
      end
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
      notification.started_working! # No need for save because this saves already
    end

  	redirect_to @bounty
  end
  

  private

	  # Use callbacks to share common setup or constraints between actions.
	  def set_bounty
	    @bounty = Bounty.find_by(id: params[:id])
	  end

	  # Never trust parameters from the scary internet, only allow the white list through.
	  def bounty_params
		 params.require(:bounty).permit(:title, :description, :price, :tag_list)
	  end
end
