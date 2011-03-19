class CommentAndLikeCountToExperience < ActiveRecord::Migration

  def self.up
    add_column :experiences, :likes_count, :integer, :default => 0
    add_column :experiences, :comments_count, :integer, :default => 0

    execute <<-SQL
    UPDATE experiences
       SET likes_count = (

    SELECT COUNT(*)

      FROM moments
        AS m

      JOIN likes
        AS l
        ON l.moment_id = m.id

     WHERE m.experience_id = experiences.id)
    SQL

    execute <<-SQL
    UPDATE experiences
       SET comments_count = (

    SELECT COUNT(*)

      FROM moments
        AS m

      JOIN comments
        AS c
        ON c.moment_id = m.id

     WHERE m.experience_id = experiences.id)
    SQL

  end

  def self.down
    remove_column :experiences, :likes_count
    remove_column :experiences, :comments_count
  end

end
