class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :realname, :limit => 100
      t.datetime :birthday
      t.integer :location_id_hometown
      t.integer :location_id_current
      t.string :website
      t.string :bio

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
