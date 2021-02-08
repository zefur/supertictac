class RenameColumnUsersInGameRoomUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :game_room_users, :users_id, :user_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
