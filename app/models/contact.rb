class Contact < ActiveRecord::Base

  has_one :user, :inverse_of => :contact

end
