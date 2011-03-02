class CreateMoments < ActiveRecord::Migration
  def self.up
    create_table :moments do |t|
      t.integer :user_id_creator
      t.integer :thing_id
      t.integer :location_id
      t.integer :caption_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :moments
  end
end
