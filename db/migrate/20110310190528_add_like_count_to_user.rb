class AddLikeCountToUser < ActiveRecord::Migration

  def self.up
    add_column :users, :likes_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :likes_count
  end

end
