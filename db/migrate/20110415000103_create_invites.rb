class CreateInvites < ActiveRecord::Migration

  def self.up
    create_table :invites do |t|
      t.integer :user_id
      t.integer :contact_id
      t.integer :user_id_to
      t.integer :experience_id

      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end

end
