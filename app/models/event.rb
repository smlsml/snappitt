class Event < ActiveRecord::Base

  belongs_to :experience, :inverse_of => :event

end
