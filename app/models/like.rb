class Like < ActiveRecord::Base

  belongs_to :user, :inverse_of => :likes, :counter_cache => true
  belongs_to :moment, :inverse_of => :likes, :counter_cache => true

end
