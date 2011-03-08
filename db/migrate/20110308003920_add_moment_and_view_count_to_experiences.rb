class AddMomentAndViewCountToExperiences < ActiveRecord::Migration

  def self.up
    add_column :experiences, :view_count, :integer, :default => 0
    add_column :experiences, :moments_count, :integer, :default => 0

    execute "UPDATE experiences AS e SET moments_count = (SELECT COUNT(*) FROM moments WHERE experience_id = e.id)"
  end

  def self.down
    remove_column :experiences, :view_count
    remove_column :experiences, :moments_count
  end

end