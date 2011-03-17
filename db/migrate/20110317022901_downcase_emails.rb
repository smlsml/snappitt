class DowncaseEmails < ActiveRecord::Migration

  def self.up
    execute "UPDATE users SET email = LOWER(email)"

    change_column :users, :username, :string, :limit => 50, :unique => true

    User.all.each do |u|
      u.username = u.email.to_s.downcase.strip.split('@')[0]
      u.save
    end

  end

  def self.down
    change_column :users, :username, :string
  end

end