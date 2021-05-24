# frozen_string_literal: true

class AddRoomNameToGameRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :game_rooms, :room_name, :string
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
