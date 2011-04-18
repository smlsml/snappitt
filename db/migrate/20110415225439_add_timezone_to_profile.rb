class AddTimezoneToProfile < ActiveRecord::Migration

  def self.up
    add_column :profiles, :timezone, :string, :limit => 100
  end

  def self.down
    remove_column :profiles, :timezone
  end

end
