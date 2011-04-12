class ExperienceCollaborator < ActiveRecord::Base

  belongs_to :experience
  belongs_to :user

  validates :experience, :presence => true
  validates :user, :presence => true
  validates :user_id, :uniqueness => {:scope => :experience_id}

end
