class ChangeCaptionToComment < ActiveRecord::Migration

  def self.up
    remove_column :moments, :caption_id
    add_column :moments, :comment_id, :integer
  end

  def self.down
    add_column :moments, :caption_id, :integer
    remove_column :moments, :comment_id
  end

end
