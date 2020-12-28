# frozen_string_literal: true

class AddGameRoomReferencesToBoards < ActiveRecord::Migration[6.0]
  def change
    add_reference :boards, :game_room, foreign_key: true
  end
end
