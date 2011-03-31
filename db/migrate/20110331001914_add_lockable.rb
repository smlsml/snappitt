class AddLockable < ActiveRecord::Migration

  def self.up

    change_table(:users) do |t|
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :email
    end

    add_index :users, :unlock_token, :unique => true

  end

  def self.down

    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :locked_at

  end

end
