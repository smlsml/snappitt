class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  after_create :setup

  belongs_to :profile, :inverse_of => :user
  belongs_to :contact, :inverse_of => :user

  has_many :services
  has_many :likes, :inverse_of => :user

  def to_s
    out = profile.realname if profile
    out || email
  end

  protected

  def setup
    self.create_profile()
    self.create_contact(:email => self.email, :name => :username)
    self.save
  end

end