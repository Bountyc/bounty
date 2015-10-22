class DisputesController < ApplicationController
    before_action :define_user

    def index

	   @disputes = Dispute.where(:moderator_id => nil).limit(10)

        if params[:search_text]
            @disputes = Dispute.joins(:bounties).search("bounties.title", params[:search_text]) .where(:status => :open).limit(10) 
        end

    end

    def new
    	@dispute = Dispute.new
    end

    def create
        @dispute = Dispute.new(bounty_params)
    	disputed_bounty_hunter = BountyHunter.find params[:bounty_hunter_id]
    	@dispute.bounty_hunter = disputed_bounty_hunter        
        @dispute.bounty_hunter.status = :disputed 
        @dispute.save
    end

    def moderate
        dispute = Dispute.find params[:id]
        byebug
        #are we doing some sort of check to make sure he's allowed to moderate this dispute?
        dispute.moderator = current_user
        dispute.save

        #todo render show_dispute page
    end

    private
        def bounty_params
            params.require(:dispute).permit(:reason)
        end
end