class ExpandEvents < ActiveRecord::Migration

  def self.up
    add_column :events, :hashtag, :string, :limit => 35, :null => false
    add_column :events, :prize, :string
    add_column :events, :prize_at_moment, :integer
  end

  def self.down
    remove_column :events, :hashtag
    remove_column :events, :prize
    remove_column :events, :prize_at_moment
  end

end
