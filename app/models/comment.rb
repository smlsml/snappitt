class Comment < ActiveRecord::Base

  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'

  def to_s
    text
  end

end
