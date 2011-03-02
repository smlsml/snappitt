class CreateEventLocations < ActiveRecord::Migration
  def self.up
    create_table :event_locations do |t|
      t.integer :event_id
      t.integer :location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_locations
  end
end
