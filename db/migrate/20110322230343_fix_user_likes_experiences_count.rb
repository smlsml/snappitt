class FixUserLikesExperiencesCount < ActiveRecord::Migration

  def self.up

    execute <<-SQL
    UPDATE users
       SET experiences_count = (

    SELECT COUNT(*)

      FROM experiences
        AS e

     WHERE e.user_id_creator = users.id)
    SQL

    execute <<-SQL
    UPDATE users
       SET likes_count = (

    SELECT COUNT(*)

      FROM moments
        AS m

      JOIN likes
        AS l
        ON l.moment_id = m.id

     WHERE m.user_id_creator = users.id)
    SQL

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
  end
end
