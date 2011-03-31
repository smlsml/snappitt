class LimitGender < ActiveRecord::Migration

  def self.up
    execute "UPDATE profiles SET gender = '' WHERE gender NOT IN ('M','F')"
    change_column :profiles, :gender, :string, :limit =>1, :null => false, :default => ""
  end

  def self.down
  end

end
