# frozen_string_literal: true

class AddPlaceToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :place, :integer
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
