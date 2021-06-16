class RemoveReferenceFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :game_room, foreign_key: true
  end
end
