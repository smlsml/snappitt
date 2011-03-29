class RemoveLikeTable < ActiveRecord::Migration

  def self.up

    execute "TRUNCATE moment_flags"

    execute <<-SQL
    INSERT INTO moment_flags (user_id, moment_id, type, updated_at, created_at)
    SELECT user_id, moment_id, 'LikeFlag', updated_at, created_at FROM likes
    SQL

    drop_table :likes
  end

  def self.down
    create_table :likes do |t|
      t.integer :user_id
      t.integer :moment_id

      t.timestamps
    end
  end

end
