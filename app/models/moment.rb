class Moment < ActiveRecord::Base

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

end