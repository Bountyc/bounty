class DisputesController < ApplicationController
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

    def new
    	@dispute = Dispute.new
    end

    def create
    	disputed_bounty = Bounty.find params[:bounty_id]
    	@dispute.bounty = disputed_bounty
    	@dispute.save
    end

   


  end
end
