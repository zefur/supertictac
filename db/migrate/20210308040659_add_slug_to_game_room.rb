class AddSlugToGameRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :game_rooms, :slug, :string
    add_index :game_rooms, :slug, unique: true
  end
end
