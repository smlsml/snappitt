class AddLatLngToAsset < ActiveRecord::Migration

  def self.up
    add_column :assets, :lat, :float
    add_column :assets, :lng, :float
    add_column :assets, :taken_at, :datetime
    add_column :assets, :device, :string, :length => 50
  end

  def self.down
    remove_column :assets, :lat
    remove_column :assets, :lng
    remove_column :assets, :taken_at
    remove_column :assets, :device
  end

end