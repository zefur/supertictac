# frozen_string_literal: true

class ChangeGameWonColumnToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :games, :game_won, :integer, default: 0
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
