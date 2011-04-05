class FixLikes < ActiveRecord::Migration

  def self.up
    execute "UPDATE causes SET action_type = 'LikeFlag' WHERE action_type = 'Like'"
  end

  def self.down
  end

end
