# frozen_string_literal: true

class AddViewersToGameRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :game_rooms, :viewers, :text
  end
end
