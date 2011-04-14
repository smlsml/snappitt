class AddShotToLike < ActiveRecord::Migration

  def self.up
    add_column :moment_flags, :shot, :string, :null => false, :default => ""
  end

  def self.down
    remove_column :moment_flags, :shot, :string, :null => false
  end

end
