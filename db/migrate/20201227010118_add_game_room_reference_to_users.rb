# frozen_string_literal: true

class AddGameRoomReferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :game_room, foreign_key: true
  end
end
