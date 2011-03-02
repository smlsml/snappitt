class Moment < ActiveRecord::Base

  belongs_to :asset
  belongs_to :source

end