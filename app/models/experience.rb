class Experience < ActiveRecord::Base

  has_one :event, :inverse_of => :experience

end
