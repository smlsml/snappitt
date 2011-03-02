class AddExperienceToEvents < ActiveRecord::Migration

  def self.up
    add_column :events, :experience_id, :integer
  end

  def self.down
    remove_column :events, :experience_id
  end

end