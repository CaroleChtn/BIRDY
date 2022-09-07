class MissionsController < ApplicationController
  def index
    # if params[:filter_category]
    #   @missions = Mission.where { |mission| mission.categories.include?(current_user.category) }
    # else
      %w[One Two Three Four Five Six Seven Eight Nine Ten Eleven Twelve Thirteen Fourteen Fiveteen Sixtenn Seven]
      @missions = Mission.all
      @user = current_user
      if params[:query].present?
        sql_query = "title ILIKE :query OR address ILIKE :query"
        @missions = Mission.where(sql_query, query: "%#{params[:query]}%")
      elsif params[:continent]

      else
        @missions = Mission.all
      end
    # end
    @markers = @missions.geocoded.map do |mission|
      {
        lat: mission.latitude,
        lng: mission.longitude,
        info_window: render_to_string(partial: "info_window", locals: {mission: mission}),
        image_url: helpers.asset_url("markermap.png")
      }
    end
    @countries = Mission.pluck(:address).uniq
  end

  def show
    @missions = Mission.all
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
