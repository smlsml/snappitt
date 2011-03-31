class DisableUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :disabled, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :users, :disabled
  end

end
