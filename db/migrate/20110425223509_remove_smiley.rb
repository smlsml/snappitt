class RemoveSmiley < ActiveRecord::Migration

  def self.up
    LikeFlag.update_all("shot = 'Must See'","shot = '=)'")
  end

  def self.down
    LikeFlag.update_all("shot = '=)'","shot = 'Must See'")
  end

end
