class VideoAsset < Asset

  def self.default_url(type = :thumb)
    '/images/default/%s/unknown.%s' % [type.to_s, (type.to_s == 'large' || type.to_s == 'preview') ? 'jpg' : 'png']
  end

  def self.from_url(url)
    io = open(URI.parse(url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
    PhotoAsset.new(:data => io)
  #rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end

  def encode
    return unless tmp_url
    video = Panda::Video.create(:source_url => tmp_url)
    self.update_attribute(:panda_id, video.id) if video
  end

  def v
    @video ||= Panda::Video.find(panda_id)
  end


end