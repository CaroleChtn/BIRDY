class FavoritesController < ApplicationController
  def create
    if Favorite.find_by(user: current_user, mission: Mission.find(params[:mission_id]))
      Favorite.find_by(user: current_user, mission: Mission.find(params[:mission_id])).destroy
      render json: { mission_id: params[:mission_id], unfav: true, page: params["page"] }
    else
      Favorite.create(user: current_user, mission: Mission.find(params[:mission_id]))
      render json: { mission_id: params[:mission_id], unfav: false, page: params["page"] }
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to root_path
  end



  # def mission_params
  #   params.require(:favorite).permit(:start_date, :end_date, :address, :price)
  # end
end
