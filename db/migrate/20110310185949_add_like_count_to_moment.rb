class AddLikeCountToMoment < ActiveRecord::Migration

  def self.up
    add_column :moments, :likes_count, :integer
  end

  def self.down
    remove_column :moments, :likes_count
  end

end
