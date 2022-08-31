class MissionsController < ApplicationController
  def index
    @missions = Mission.all
    @markers = @missions.geocoded.map do |mission|
      {
        lat: mission.latitude,
        lng: mission.longitude
      }
    end
  end

  def show
    @mission = Mission.find(params[:id])
    if params[:booking]
    @booking = Booking.find(params[:booking])
    else
    @booking = Booking.new
    end
    @user = current_user
  end

  # private

  # def mission_params
  #   params.require(:mission).permit(:title, :description, :address, :price)
  # end
end
