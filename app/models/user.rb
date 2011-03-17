class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  before_create :lower_email
  after_create :setup

  belongs_to :profile, :inverse_of => :user
  belongs_to :contact, :inverse_of => :user

  has_many :services
  has_many :likes, :inverse_of => :user

  has_many :connections_in, :class_name => 'Connection', :foreign_key => 'user_id_to'
  has_many :connections_out, :class_name => 'Connection', :foreign_key => 'user_id_from'

  has_many :following, :through => :connections_out, :class_name => 'User', :source => :to
  has_many :followers, :through => :connections_in, :class_name => 'User', :source => :from

  has_many :experiences, :foreign_key => 'user_id_creator'

  def follows(user)
    following.exists?(user) || self.id == user.id
  end

  def followed_by(user)
    followers.exists?(user)
  end

  def to_s
    out = profile.realname if profile
    out || email
  end

  def self.generate_password(len = 8)
    chars = (('A'..'Z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..len).collect{|a| chars[rand(chars.size)] }.join
  end

  protected

  def lower_email
    self.email.downcase!
    self.confirmed_at = Time.now
    true
  end

  def setup
    self.create_profile()
    self.create_contact(:email => self.email, :name => :username)
    self.save
  end

end