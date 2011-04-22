class Invite < ActiveRecord::Base

  belongs_to :user
  belongs_to :to, :class_name => "User", :foreign_key => :user_id_to
  belongs_to :contact
  belongs_to :experience

end
