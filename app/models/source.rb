class Source < ActiveRecord::Base

  def self.find_or_create_from_request(request)
    self.find_or_create_by_name(request.env['HTTP_USER_AGENT'] || 'unknown')
  end

end
