class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name

      t.string :address1
      t.string :address2
      t.string :city, :limit => 100
      t.string :state, :limit => 2
      t.string :zip, :limit => 10
      t.string :precision, :limit => 30, :default => 'unknown'

      t.float :lat
      t.float :lng
      t.integer :meter_radius

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
