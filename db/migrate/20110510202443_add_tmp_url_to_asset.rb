class AddTmpUrlToAsset < ActiveRecord::Migration

  def self.up
    add_column :assets, :tmp_url, :string
    add_column :assets, :panda_id, :string
  end

  def self.down
    remove_column :assets, :tmp_url
    remove_column :assets, :panda_id
  end

end
