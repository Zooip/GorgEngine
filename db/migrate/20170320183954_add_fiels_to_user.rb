class AddFielsToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :is_gadz, :boolean
    add_column :users, :uuid, :string
    add_column :users, :last_gram_sync_at, :datetime
    add_column :users, :hruid, :string, null: false, default: ""


    add_index :users, :uuid,                unique: true
    add_index :users, :hruid,                unique: true
    add_index :users, :is_gadz

  end

  def self.up
    change_column :users, :hruid, :string, :null => false
    remove_index :users, :email
  end

  def self.down
    change_column :users, :email, :string, :null => false
    add_index :users, :email,                unique: true
  end
end
