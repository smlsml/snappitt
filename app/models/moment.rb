class Moment < ActiveRecord::Base

  after_create :create_cause

  belongs_to :creator, :class_name => "User", :foreign_key => 'user_id_creator'

  belongs_to :asset, :dependent => :destroy
  belongs_to :source
  belongs_to :thing
  belongs_to :location
  belongs_to :experience, :counter_cache => true
  belongs_to :caption, :class_name => 'CaptionComment', :dependent => :destroy#, :inverse_of => :moment

  has_many :likes, :inverse_of => :moment, :dependent => :destroy
  has_many :comments, :class_name => 'MomentComment', :inverse_of => :moment, :dependent => :destroy

  accepts_nested_attributes_for :caption


  def photo_url(type = :thumb)
    url = asset.data.url(type) if asset
    url || PhotoAsset.default_url(type)
  end

  def title
    '%s @ %s' % [thing, location]
  end

  def to_s
    title
  end


  def self.experience_id_for(moment_id)
    Moment.find(moment_id, :select => 'experience_id').experience_id
  end

  def self.increment_counter(field, id)
    super(field, id)
    Experience.increment_counter(field, Moment.experience_id_for(id))
  end

  def self.decrement_counter(field, id)
    super(field, id)
    Experience.decrement_counter(field, Moment.experience_id_for(id))
  end


  class CreateCause < Cause
    def verb; 'uploaded a moment to'; end
  end

  protected

  def create_cause
    CreateCause.create!(:user => creator, :action => self, :subject => experience)
  end

end