class RemovePasswordFromUsers < ActiveRecord::Migration

  def self.up
    remove_column :users, :password
  end

  def self.down
    add_column :users, :password, :string, :limit => 100
  end

end
