# frozen_string_literal: true

class CreateGameRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :game_rooms, &:timestamps
  end
end
