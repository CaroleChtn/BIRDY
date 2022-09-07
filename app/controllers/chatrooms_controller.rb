class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def new
    @chatroom = Chatroom.new()
  end

  def create
    user = User.find(params[:user_id])
    @chatroom = current_user.chatroom_with(user)

    if @chatroom.present?
      redirect_to chatroom_path(@chatroom)
    else
      @chatroom = Chatroom.create(name: "#{current_user.name} & #{user.name}")

      Participation.create(chatroom: @chatroom, user: current_user)
      Participation.create(chatroom: @chatroom, user: user)

      redirect_to chatroom_path(@chatroom)
    end
  end
end
