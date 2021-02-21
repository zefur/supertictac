class AddDefaultToPlayerTurn < ActiveRecord::Migration[6.0]
  def change
    change_column_default :game_rooms, :player_turn, from: nil, to: 0
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
