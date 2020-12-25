# frozen_string_literal: true

class AddDefaultValueToMark < ActiveRecord::Migration[6.0]
  def change
    change_column :cells, :mark, :integer, default: 0
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
