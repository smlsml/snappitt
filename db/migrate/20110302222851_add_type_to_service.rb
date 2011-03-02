class AddTypeToService < ActiveRecord::Migration

  def self.up
    add_column :services, :type, :string, :limit => 25
  end

  def self.down
    remove_column :services, :type
  end
end
