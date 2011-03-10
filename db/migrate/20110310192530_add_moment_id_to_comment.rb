class AddMomentIdToComment < ActiveRecord::Migration

  def self.up
    add_column :comments, :moment_id, :integer
  end

  def self.down
    remove_column :comments, :moment_id
  end

end
