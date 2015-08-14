class BountiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  	@bounties = Bounty.all
  end

  def show
  	set_bounty
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bounty
    @bounty = Bounty.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bounty_params
	 params.require(:bounty).permit(:title, :description)
  end
end
