class GameRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_room_#{current_or_guest_user}"
    GameRoom.create(current_or_guest_user)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
