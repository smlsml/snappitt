class AlterExperienceVisibility < ActiveRecord::Migration

  def self.up
    change_column :experiences, :visibility, :string, :null => false, :default => 'public', :limit => 7
  end

  def self.down
    change_column :experiences, :visibility, :string, :default => 'public', :limit => 7
  end

end
