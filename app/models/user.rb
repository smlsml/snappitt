class User < ActiveRecord::Base

  belongs_to :profile, :inverse_of => :user
  belongs_to :contact, :inverse_of => :user

  has_many :services

  def to_param
    username
  end

end
