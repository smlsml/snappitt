class Service < ActiveRecord::Base

  belongs_to :user, :inverse_of => :service

end
