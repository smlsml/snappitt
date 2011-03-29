class CreateMomentFlags < ActiveRecord::Migration
  def self.up
    create_table :moment_flags do |t|
      t.integer :user_id, :null => false
      t.integer :moment_id, :null => false
      t.string :type, :limit => 50, :null => false

      t.timestamps
    end

    add_index :moment_flags, :user_id
    add_index :moment_flags, :moment_id

    execute "UPDATE causes SET type = 'LikeFlag::CreateCause' WHERE type = 'Like::CreateCause'"
  end

  def self.down
    drop_table :moment_flags
  end
end
