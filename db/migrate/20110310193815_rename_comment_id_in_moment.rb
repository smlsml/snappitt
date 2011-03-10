class RenameCommentIdInMoment < ActiveRecord::Migration

  def self.up
    rename_column :moments, :comment_id, :caption_id
  end

  def self.down
    rename_column :moments, :caption_id, :comment_id
  end

end
