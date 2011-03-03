class User < ActiveRecord::Base

  belongs_to :profile
  belongs_to :contact

end
