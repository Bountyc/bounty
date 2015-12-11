class BountiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :define_user
  include Bounties

  def index

    limit = 10
    gon.limit = limit
    
    @open_bounties = get_bounties({status: 0, search: params[:search_text], limit: limit})
    @open_bounties_count = count_bounties({status: 0, search: params[:search_text]})

    @resolved_bounties = get_bounties({status: 2, search: params[:search_text], limit: limit})
    @resolved_bounties_count = count_bounties({status: 2, search: params[:search_text]})

    if user_signed_in?
      @my_bounties = get_bounties({user_id: current_user.id, search: params[:search_text], limit: limit})
      @my_bounties_count = count_bounties({user_id: current_user.id, search: params[:search_text]})
      gon.user_id = current_user.id
    end

    @total_bounty_money_available = Bounty.sum(:price, :conditions => {:status => 0})
    render layout: 'homepage'
  end

  def show
  	set_bounty

    @dispute = Dispute.new
    @answer = Answer.new

    if @bounty.nil?
      redirect_to root_url
    else
    	if @bounty.poster == current_user
    		@user_role = :poster
    	elsif user_signed_in?
    		if @bounty.hunters.include? current_user
    			@bounty_hunter_relation_object = @bounty.bounty_hunters.find_by_user_id(current_user)
          @user_role = @bounty_hunter_relation_object.status.to_sym

          #Check for dispute
          if @bounty_hunter_relation_object.disputed?
            @dispute = @bounty_hunter_relation_object.dispute
          end
    		else
    			@user_role = :hunter
    		end
    	else
    		@user_role = :guest
    	end
      

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
      if @bounty.nil? or current_user != @bounty.poster or @bounty.status == "closed"
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
