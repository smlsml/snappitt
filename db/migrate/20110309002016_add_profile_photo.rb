class AddProfilePhoto < ActiveRecord::Migration

  def self.up
    remove_column :assets, :original_filename
    add_column :profiles, :photo_asset_id, :integer
  end

  def self.down
    add_column :assets, :original_filename, :string
    remove_column :profiles, :photo_asset_id
  end

end
