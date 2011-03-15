require "open-uri"
class PhotoAsset < Asset

  def self.from_url(url)
    io = open(URI.parse(url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
    PhotoAsset.new(:data => io)
  #rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end


end