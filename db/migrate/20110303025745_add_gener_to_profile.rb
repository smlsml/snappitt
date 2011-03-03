class AddGenerToProfile < ActiveRecord::Migration

  def self.up
    add_column :profiles, :gender, :string, :default => 'unknown', :limit => "7"
  end

  def self.down
    remove_column :profiles, :gender
  end

end
