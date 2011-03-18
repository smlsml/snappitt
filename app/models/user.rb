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

  attr_accessor :login
  attr_accessible :email, :username, :login, :password, :remember_me

  validates :username, :presence => true, :length => { :minimum => 2 }, :uniqueness => true

  before_create :downcase
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
    out = '%s (@%s)' % [username, profile.realname] if profile && profile.realname
    out || '@' % username
  end

  def self.generate_password(len = 8)
    chars = (('A'..'Z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..len).collect{|a| chars[rand(chars.size)] }.join
  end

  def self.find_for_database_authentication(conditions)
     login = conditions.delete(:login)
     where(conditions).where(["username = :value OR email = :value", {:value => login }]).first
   end

  protected

  def downcase
    self.email.downcase!
    self.username.downcase!
    true
  end

  def setup
    self.create_profile(:realname => self.username)
    self.create_contact(:email => self.email, :name => self.username)
    self.save!
  end

end