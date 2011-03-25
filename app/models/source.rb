class Source < ActiveRecord::Base

  def self.find_or_create_from_request(request)
    self.find_or_create_by_name(request.env['HTTP_USER_AGENT'] || 'unknown')
  end

  def short
    return 'iPhone' if name.to_s.downcase.include?('iphone')
    return 'email' if name.to_s.downcase.include?('cloudmailin')
    return 'firefox' if name.to_s.downcase.include?('firefox')
    return 'chrome' if name.to_s.downcase.include?('chrome')
    return 'browser'
  end

  def to_s
    short
  end

end
