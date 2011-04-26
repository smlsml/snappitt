class Profile < ActiveRecord::Base

  has_one :user, :inverse_of => :profile

  belongs_to :hometown, :class_name => 'Location', :foreign_key => 'location_id_hometown'
  belongs_to :current_location, :class_name => 'Location', :foreign_key => 'location_id_current'

  belongs_to :photo_asset
  belongs_to :zodiac_western, :class_name => 'Zodiac::Western'

  accepts_nested_attributes_for :hometown, :current_location

  validates :gender, :inclusion => ['','M','F'], :length => { :maximum => 1 }

  def photo_url(type = :thumb)
    url = photo_asset.data.url(type) if photo_asset
    url || PhotoAsset.default_url(type)
  end

  def has_photo?
    !photo_asset.blank?
  end

  def can_email?(type)
    !dont_notify_for.include?(type)
  end

  def realname_unless
    realname unless user.username == realname
  end

  def his_her
    case gender.to_s.downcase
      when 'm'
        'his'
      when 'f'
        'her'
      else
        'their'
    end
  end

  def he_she
    case gender.to_s.downcase
      when 'm'
        'he'
      when 'f'
        'she'
      else
        'they'
    end
  end

  def zodiac_chinese
    return nil if self.birthday.blank?
    @zc ||= Zodiac::Chinese.from_year(self.birthday.year)
  end

  def tagline
    (user.profile.bio.blank? ? nil:user.profile.bio) || user.profile.zodiac_western || user.profile.zodiac_chinese
  end

end