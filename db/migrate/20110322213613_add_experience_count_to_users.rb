class AddExperienceCountToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :experiences_count, :integer, :null => false, :default => 0

    execute <<-SQL
    UPDATE users
       SET likes_count = (

    SELECT COUNT(*)

      FROM experiences
        AS e

     WHERE e.user_id_creator = users.id)
    SQL

  end

  def self.down
    remove_column :users, :experiences_count
  end

end