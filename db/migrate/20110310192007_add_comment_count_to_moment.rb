class AddCommentCountToMoment < ActiveRecord::Migration

  def self.up
    add_column :moments, :comments_count, :integer, :default => 0
  end

  def self.down
    remove_column :moments, :comments_count
  end

end
