class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.mission = Mission.find(params[:mission_id])
    @booking.user = current_user
    if @booking.save
      flash.alert = "Réservation validé!"
      @chatroom = Chatroom.create(name: @booking.mission.title, booking: @booking)
      redirect_to dashboards_path(booking: true)
    else
      flash.alert = "Erreur!"
      redirect_to mission_path(@booking.mission)
    end
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      flash.alert = "Réservation mise à jour!!"
      redirect_to dashboards_path
    else
      render "missions#show", status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to dashboards_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :mission_id)
  end
end
