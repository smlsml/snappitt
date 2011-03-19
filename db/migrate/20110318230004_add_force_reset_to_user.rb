class AddForceResetToUser < ActiveRecord::Migration

  def self.up
    add_column :users, :force_reset, :boolean
  end

  def self.down
    remove_column :users, :force_reset, :boolean
  end

end
