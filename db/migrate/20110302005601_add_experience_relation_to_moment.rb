class AddExperienceRelationToMoment < ActiveRecord::Migration
  def self.up
    add_column :moments, :experience_id, :integer
  end

  def self.down
    remove_column :moments, :experience_id
  end
end
