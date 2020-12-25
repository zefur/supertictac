# frozen_string_literal: true

class AddValueToCells < ActiveRecord::Migration[6.0]
  def change
    add_column :cells, :value, :boolean
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
