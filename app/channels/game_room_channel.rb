# frozen_string_literal: true

class GameRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for(GameRoom.find(params[:id]))
  end

  def unsubscribed
    #  # Any cleanup needed when channel is unsubscribed
    #  stop_stream_from room
  end
end
