class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.string :title
      t.integer :user_id_creator
      t.string :visibility

      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
