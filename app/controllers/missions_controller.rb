class MissionsController < ApplicationController
  def index
    @missions = Mission.all
    @user = current_user
        if params[:query].present?
          sql_query = "title ILIKE :query OR address ILIKE :query"
          @missions = Mission.where(sql_query, query: "%#{params[:query]}%")
        else
          @missions = Mission.all
        end
    @markers = @missions.geocoded.map do |mission|
      {
        lat: mission.latitude,
        lng: mission.longitude,
        info_window: render_to_string(partial: "info_window", locals: {mission: mission}),
        image_url: helpers.asset_url("markermap.png")
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
