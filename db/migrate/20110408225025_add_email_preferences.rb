class AddEmailPreferences < ActiveRecord::Migration

  def self.up
    add_column :profiles, :dont_notify_for, :string, :default => '', :null => false
  end

  def self.down
    remove_column :profiles, :dont_notify_for
  end

end
