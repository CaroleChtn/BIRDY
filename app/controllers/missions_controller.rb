class MissionsController < ApplicationController
  def index
    @missions = Mission.all
  end

  def show
    @mission = Mission.find(params[:id])
  end

  # private

  # def mission_params
  #   params.require(:mission).permit(:title, :description, :address, :price)
  # end
end
