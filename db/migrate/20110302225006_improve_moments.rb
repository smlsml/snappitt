class ImproveMoments < ActiveRecord::Migration

  def self.up
    add_column :moments, :source_id, :integer
    add_column :moments, :asset_id, :integer
  end

  def self.down
    remove_column :moments, :source_id
    remove_column :moments, :asset_id
  end

end