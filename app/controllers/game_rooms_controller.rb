# frozen_string_literal: true

class GameRoomsController < ApplicationController
  helper_method :current_user
  before_action :set_game_rooms
  include CableReady::Broadcaster
  require 'faker'
  def index
    @game_rooms
  end

  def join_match
    # Trying to make a joins table so I can link users to a game (and then use that to reject non linked users from the channel)

    @game_room = GameRoom.friendly.find(params[:id])
    @game_room.join(current_user)
    redirect_to game_room_path(@game_room)
  end

  def leave
    @game_room = GameRoom.friendly.find(params[:id])
    @game_room.leave(current_user)
    
    redirect_to game_rooms_path
  end

  def new
    @game_room = GameRoom.new
    @board = Board.new
    @user
  end

  def create
    

    
    
    @game_room = GameRoom.new(game_room_params)
    @game_room.room_name ||= "#{@user}'s #{Faker::Color.color_name} room"
    
    if @game_room.save
    @board = Board.create(game_room_id: @game_room.id)
    Game.create(board_id: @board.id, place: 1)
    Game.create(board_id: @board.id, place: 2)
    Game.create(board_id: @board.id, place: 3)
    Game.create(board_id: @board.id, place: 4)
    Game.create(board_id: @board.id, place: 5)
    Game.create(board_id: @board.id, place: 6)
    Game.create(board_id: @board.id, place: 7)
    Game.create(board_id: @board.id, place: 8)
    Game.create(board_id: @board.id, place: 9)

    @board.games.each do |game|
      Cell.create(game_id: game.id, place: 1)
      Cell.create(game_id: game.id, place: 2)
      Cell.create(game_id: game.id, place: 3)
      Cell.create(game_id: game.id, place: 4)
      Cell.create(game_id: game.id, place: 5)
      Cell.create(game_id: game.id, place: 6)
      Cell.create(game_id: game.id, place: 7)
      Cell.create(game_id: game.id, place: 8)
      Cell.create(game_id: game.id, place: 9)
    end
       else 
    raise
    end
    @game_room.join(current_user)
    redirect_to game_room_path(@game_room)
  end

  def show
    @game_room = GameRoom.friendly.find(params[:id])
    @game_room.join(current_user)
    @board = @game_room.board
    @games = @board.games
  end


  def destroy
    @game_room = GameRoom.friendly.find(params[:id])
    @game_room.destroy
    redirect_to root_path
  end

  private

  def game_room_params
    params.require(:game_room).permit(:room_name, :user_id)
  end



  def set_game_rooms
    @game_rooms = GameRoom.all
    @user = current_or_guest_user
  end
end
