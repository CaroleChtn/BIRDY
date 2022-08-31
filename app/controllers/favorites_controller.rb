class FavoritesController < ApplicationController
  def create
   @favorite = Favortie.new(mission_params)
   @favorite = Favorite.find(params[:mission_id])
   if @favortie.save
     flash.alert = "Your booking is ok!"
     redirect_to dashboards_path
   else
     render :new, status: :unprocessable_entity
   end
 end

  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to root_path
  end

  private


  def mission_params
    params.require(:favorite).permit(:start_date, :end_date, :mission_id)
  end
