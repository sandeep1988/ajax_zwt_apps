class AddStatusFieldToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :role, :string
  end
end
