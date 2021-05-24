# frozen_string_literal: true

class AddUserReferenceToGameRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :game_rooms, :user, foreign_key: true
  end
end
