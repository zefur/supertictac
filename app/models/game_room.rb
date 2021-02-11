# frozen_string_literal: true

class GameRoom < ApplicationRecord
  has_one :board, dependent: :destroy
  has_many :game_room_users, dependent: :destroy
  has_many :users, through: :game_room_users
  serialize :players, Array
  serialize :viewers, Array
  # validates_length_of :users, maximum: 2

  def join
    if @game_room.players.count < 2
      @game_room.players << @user
      else
        @game_room.viewers << @user
      end
      @game_room.save
  end

  def leave

  end
end
