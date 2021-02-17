# frozen_string_literal: true

class GameRoomChannel < ApplicationCable::Channel
 

  def subscribed
    room = GameRoom.find(params[:id])
    puts "*********************"
    puts room.players
    puts "*********************"
    
    stream_for(GameRoom.find(params[:id]))
    
    stream_from("player_#{current_or_guest_user.user_name}")
    # below doesnt work
    #Match.create(current_or_guest_user)
  end

  def unsubscribed
    #  # Any cleanup needed when channel is unsubscribed
    
  end



  private

  def pick_players; end
end
# {current_or_guest_user.uuid} GameRoom.create(current_or_guest_user)
