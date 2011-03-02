class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name, :limit => 100
      t.string :email, :limit => 200
      t.string :facebook, :limit => 50
      t.string :twitter, :limit => 50
      t.string :phone, :limit => 20
      t.string :skype, :limit => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
