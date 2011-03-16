class Source < ActiveRecord::Base

  def self.find_or_create_from_request(request)
    self.find_or_create_by_name(request.env['HTTP_USER_AGENT'] || 'unknown')
  end

  def to_s
    return 'iPhone' if name.to_s.downcase.include?('iphone')
    return 'Email' if name.to_s.downcase.include?('cloudmailin')
    return 'Web'
  end

end
