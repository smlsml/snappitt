class Comment < ActiveRecord::Base

  belongs_to :user
  validates :user, :presence => true

  def to_s
    text
  end

end