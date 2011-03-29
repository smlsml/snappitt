class UndoUserIdCreator < ActiveRecord::Migration

  def self.up
    Asset.delete_all('user_id_creator IS NULL')

    execute <<-SQL
    DELETE
      FROM moments
     WHERE id
        IN (
    SELECT m.id

      FROM moments
        AS m

      LEFT
      JOIN assets
        AS a
        ON a.id = m.asset_id

     WHERE a.id IS NULL)
    SQL

    rename_column :assets, :user_id_creator, :user_id
    change_column :assets, :user_id, :integer, :null => false
  end

  def self.down
    rename_column :assets, :user_id, :user_id_creator
    change_column :assets, :user_id_creator, :integer, :null => false
  end

end
