# frozen_string_literal: true

class ChangeColumnNameInCells < ActiveRecord::Migration[6.0]
  def change
    rename_column :cells, :value, :mark
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
