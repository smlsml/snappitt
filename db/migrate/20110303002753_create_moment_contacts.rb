class CreateMomentContacts < ActiveRecord::Migration
  def self.up
    create_table :moment_contacts do |t|
      t.integer :moment_id
      t.integer :contact_id

      t.timestamps
    end
  end

  def self.down
    drop_table :moment_contacts
  end
end
