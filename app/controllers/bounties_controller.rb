class BountiesController < ApplicationController
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

    respond_to do |format|
      if @bounty.save
        format.html { redirect_to @bounty, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
