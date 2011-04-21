class AddMomentCoverToExperience < ActiveRecord::Migration

  def self.up
    add_column :experiences, :moment_id_cover, :integer
    Experience.all.each{|e| e.cover = e.moments.first; e.save}
  end

  def self.down
    remove_column :experiences, :moment_id_cover
  end

end
