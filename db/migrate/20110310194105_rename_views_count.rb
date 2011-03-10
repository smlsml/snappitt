class RenameViewsCount < ActiveRecord::Migration

  def self.up
    rename_column :experiences, :view_count, :views
  end

  def self.down
    rename_column :experiences, :views, :view_count
  end

end
