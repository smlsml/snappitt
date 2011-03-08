class ClearUsers < ActiveRecord::Migration

  def self.up
    execute "TRUNCATE users"
    execute "TRUNCATE contacts"
    execute "TRUNCATE profiles"
    execute "TRUNCATE connections"
  end

  def self.down
  end

end