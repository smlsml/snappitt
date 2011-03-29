class UndoUserIdCreatorMoments < ActiveRecord::Migration

  def self.up
    Experience.delete_all('user_id_creator IS NULL')
    Moment.delete_all('user_id_creator IS NULL')

    rename_column :moments, :user_id_creator, :user_id
    change_column :moments, :user_id, :integer, :null => false

    rename_column :experiences, :user_id_creator, :user_id
    change_column :experiences, :user_id, :integer, :null => false
  end

  def self.down
    rename_column :moments, :user_id, :user_id_creator
    change_column :moments, :user_id_creator, :integer, :null => false

    rename_column :experiences, :user_id, :user_id_creator
    change_column :experiences, :user_id_creator, :integer, :null => false
  end

end
