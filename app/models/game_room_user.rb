class GameRoomUser < ApplicationRecord
  belongs_to :game_room
  belongs_to :users
end
