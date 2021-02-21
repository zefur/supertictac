class RenameColumnServerToPlayerTurn < ActiveRecord::Migration[6.0]
  def change
    rename_column :game_rooms, :server, :player_turn
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
