class RenameActiveColumnInGames < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :active, :status
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
