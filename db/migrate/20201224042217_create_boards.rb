# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.boolean :game_finishd, default: false

      t.timestamps
    end
  end
end
