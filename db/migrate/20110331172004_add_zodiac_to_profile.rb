class AddZodiacToProfile < ActiveRecord::Migration

  def self.up
    add_column :profiles, :zodiac_western_id, :integer
  end

  def self.down
    remove_column :profiles, :zodiac_western_id
  end

end
