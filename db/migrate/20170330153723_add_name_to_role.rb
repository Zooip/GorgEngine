class AddNameToRole < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :name, :string
  end
end
