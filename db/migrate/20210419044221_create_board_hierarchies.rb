class CreateBoardHierarchies < ActiveRecord::Migration[6.0]
  def change
    create_table :board_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :board_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "board_anc_desc_idx"

    add_index :board_hierarchies, [:descendant_id],
      name: "board_desc_idx"
  end
end
