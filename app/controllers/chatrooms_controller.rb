class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def new
    @chatroom = Chatroom.new()
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    @chatroom.mission = Mission.find(params[:mission_id])
    @chatroom.user = current_user
    @chatroom.chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      # flash.alert = "Réservation validé!"
      # redirect_to dashboards_path(chatroom: true)
    else
      # flash.alert = "Erreur!"
      # redirect_to mission_path(@chatroom.mission)
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name, :booking_id)
  end
end
