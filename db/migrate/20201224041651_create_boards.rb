class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.boolean :boardEnd

      t.timestamps
    end
  end
end
