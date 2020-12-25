class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.board :references
      t.boolean :gameEnd

      t.timestamps
    end
  end
end
