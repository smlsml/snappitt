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

  after_create :setup_profile

  has_one :profile, :inverse_of => :user
  belongs_to :contact, :inverse_of => :user

  has_many :services

  def to_s
    email
  end

  protected

  def setup_profile
    Profile.create!(:user_id => self.id)
  end

  def create_contact
    Contact.create!(:user_id => self.id, :email => self.email)
  end

end