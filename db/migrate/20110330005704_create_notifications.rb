class CreateNotifications < ActiveRecord::Migration

  def self.up
    create_table :notifications do |t|
      t.integer :user_id, :null => false
      t.integer :cause_id, :null => false
      t.boolean :seen, :null => false, :default => false

      t.timestamps
    end

    add_index :notifications, [:user_id, :seen]
  end

  def self.down
    drop_table :notifications
  end

end
