class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :timeoutable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable,
         :maximum_attempts => 5,
         :lock_strategy => :failed_attempts,
         :unlock_strategy => :email

  attr_accessor :login, :newly_created
  attr_accessible :email, :username, :login, :password, :remember_me

  validates :username, :presence => true, :length => { :minimum => 2 }, :uniqueness => true

  before_create :downcase
  after_create :setup

  belongs_to :profile, :inverse_of => :user
  belongs_to :contact, :inverse_of => :user

  has_many :services
  has_many :likes, :class_name => 'LikeFlag', :inverse_of => :user

  has_many :connections_in, :class_name => 'Connection', :foreign_key => 'user_id_to'
  has_many :connections_out, :class_name => 'Connection', :foreign_key => 'user_id_from'

  has_many :following, :through => :connections_out, :class_name => 'User', :source => :to
  has_many :followers, :through => :connections_in, :class_name => 'User', :source => :from

  has_many :experiences, :foreign_key => 'user_id'

  has_many :notifications do
    def unseen
      where(:seen => false)
    end
  end

  scope :most_active, lambda {
    where(:confirmed_at.ne => nil).
    order('experiences_count DESC').
    limit(50)
  }

  scope :newest, lambda {
    where(:confirmed_at.ne => nil).
    order('created_at DESC').
    limit(50)
  }

  def follows(user)
    following.exists?(user) || self.id == user.id
  end

  def followed_by(user)
    followers.exists?(user)
  end

  def to_s
    username
  end

  def admin?
    role == 'admin'
  end

  def publish?
    email =~ /@likeme.net/i || email =~ /@westword.com/i
  end

  def unseen_notifications?
    notifications.unseen.count > 0
  end

  def permissions
    p = [:create]
    p += [:like, :comment] if confirmed?
    p += [:delete, :publish] if admin?
    p += [:publish] if publish?
    p.flatten.uniq
  end

  def access_locked?
    return true if disabled?
    super
  end

  #--

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
    self.newly_created = true
  end

end