class Invite < ActiveRecord::Base

  belongs_to :user
  belongs_to :to, :class_name => "User", :foreign_key => :user_id_to
  belongs_to :contact
  belongs_to :experience

  def email
    return(self.to.email) if self.to
    contact.email
  end

end
