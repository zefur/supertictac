# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :board, null: false, foreign_key: true
      t.boolean :game_won, default: false

      t.timestamps
    end
  end
end
