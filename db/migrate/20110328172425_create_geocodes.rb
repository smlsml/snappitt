class CreateGeocodes < ActiveRecord::Migration

  def self.up
    create_table :geocodes do |t|
      t.float :lat, :null => false
      t.float :lng, :null => false
      t.string :street
      t.string :city, :limit => 100
      t.string :state, :limit => 2
      t.string :zip, :limit => 10
      t.string :country, :limit => 100
      t.datetime :lookup_at
      t.boolean :success

      t.timestamps
    end

    add_index :geocodes, [:lat, :lng], :unique => true

  end

  def self.down
    drop_table :geocodes
  end

end
