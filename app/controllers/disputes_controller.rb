class DisputesController < ApplicationController
    before_action :authenticate_user!
    before_action :define_user
    include Messages
    include Disputes

    def index
        if current_user.reputation < 50
            redirect_to :bounties
            
        end
	   @disputes = Dispute.where(:moderator_id => nil).limit(10)
       @my_disputes = my_disputes(current_user)

        if params[:search_text]
            @disputes = Dispute.joins(:bounties).search("bounties.title", params[:search_text]) .where(:status => :open).limit(10) 
        end

    end



    def new
    	@dispute = Dispute.new
    end

    def show
        @dispute = Dispute.find(params[:id])
        @messages = @dispute.messages

        if current_user == @dispute.moderator
            @user_role = :moderator
        elsif current_user == @dispute.hunter
            @user_role = :hunter
        elsif current_user == @dispute.poster
            @user_role = :poster
        else
            @user_role = :audience
        end
    end
    
    def create
        @dispute = Dispute.new(bounty_params)
    	disputed_bounty_hunter = BountyHunter.find params[:bounty_hunter_id]
    	@dispute.bounty_hunter = disputed_bounty_hunter        
        @dispute.bounty_hunter.status = :disputed 
        @dispute.save
    end

    def moderate
        @dispute = Dispute.find params[:id]
        unless @dispute.hunter == current_user || @dispute.poster == current_user || current_user.reputation < 100
            @dispute.moderator = current_user
            @dispute.save
            render 'show'
        else
            redirect_to :bounties
        end
        
    end

    private
        def bounty_params
            params.require(:dispute).permit(:reason)
        end
end