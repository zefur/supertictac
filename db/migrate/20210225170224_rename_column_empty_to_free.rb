# frozen_string_literal: true

class RenameColumnEmptyToFree < ActiveRecord::Migration[6.0]
  def change
    rename_column :cells, :empty, :free
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
