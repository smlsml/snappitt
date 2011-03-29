class CreateCauses < ActiveRecord::Migration
  def self.up
    create_table :causes do |t|
      t.integer :user_id, :null => false
      t.integer :action_id, :null => false
      t.string :action_type, :null => false, :limit => 50
      t.integer :subject_id, :null => false
      t.string :subject_type, :null => false, :limit => 50
      t.string :type, :null => false, :limit => 50

      t.timestamps
    end

    add_index :causes, :user_id
    add_index :causes, [:action_type, :action_id]
    add_index :causes, [:subject_type, :subject_id]
  end

  def self.down
    drop_table :causes
  end
end
