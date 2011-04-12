class CreateExperienceCollaborators < ActiveRecord::Migration
  def self.up
    create_table :experience_collaborators do |t|
      t.integer :experience_id
      t.integer :user_id
    end

    add_index :experience_collaborators, [:experience_id, :user_id], :unique => true

    Experience.all.each do |e|
      ExperienceCollaborator.create(:experience => e, :user => e.user)
      e.moments.each do |m|
        ExperienceCollaborator.create(:experience => e, :user => m.user)
        m.likes.each do |l|
          ExperienceCollaborator.create(:experience => e, :user => l.user)
        end
        m.comments.each do |c|
          ExperienceCollaborator.create(:experience => e, :user => c.user)
        end
        m.publishes.each do |p|
          ExperienceCollaborator.create(:experience => e, :user => p.user)
        end
      end
    end

  end

  def self.down
    drop_table :experience_collaborators
  end
end
