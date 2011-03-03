class MomentContact < ActiveRecord::Base

  belongs_to :moment
  belongs_to :contact

end