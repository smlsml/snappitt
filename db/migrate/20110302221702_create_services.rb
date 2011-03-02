class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.integer :user_id
      t.integer :id_external
      t.string :token

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
