class AddProfileContactToUser < ActiveRecord::Migration

  def self.up
    add_column :users, :contact_id, :integer
    add_column :users, :profile_id, :integer
  end

  def self.down
    remove_column :users, :contact_id
    remove_column :users, :profile_id
  end

end