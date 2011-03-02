class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :user_id_creator
      t.integer :source_id
      t.string :type, :limit => 30
      t.string :original_filename

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
