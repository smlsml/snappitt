class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    self.down

    change_table(:users) do |t|
      t.database_authenticatable :null => false
      t.encryptable
      t.recoverable
      t.rememberable
      t.trackable

      t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users

    create_table :users do |t|
      t.string :username, :limit => 25
      t.string :password, :limit => 100
      t.string :role, :default => 'user', :limit => 20

      t.timestamps
    end
  end
end
