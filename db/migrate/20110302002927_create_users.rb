class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :limit => 25
      t.string :password, :limit => 100
      t.string :role, :default => 'user', :limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
