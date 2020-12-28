# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :wins, :integer, default: 0
    add_column :users, :losses, :integer, default: 0
    add_column :users, :draws, :integer, default: 0
    add_column :users, :user_name, :string

    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
