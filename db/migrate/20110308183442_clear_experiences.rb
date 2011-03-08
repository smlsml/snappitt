class ClearExperiences < ActiveRecord::Migration

  def self.up
    execute "TRUNCATE TABLE experiences"
    execute "TRUNCATE TABLE comments"
    execute "TRUNCATE TABLE assets"
    execute "TRUNCATE TABLE locations"
    execute "TRUNCATE TABLE things"
    execute "TRUNCATE TABLE moments"
  end

  def self.down
  end

end