# frozen_string_literal: true

class GameRoom < ApplicationRecord
  has_one :board, dependent: :destroy
  has_many :game_room_users, dependent: :destroy
  has_many :users, through: :game_room_users
  # validates_length_of :users, maximum: 2

  def self.start(player1,player2)
    cross,nought = [player1,player2]

  end
end
