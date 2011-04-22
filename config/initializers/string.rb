class String

  def possessive
    '%s%s' % [self, self.last == 's' ? "\'" : "\'s"]
  end

  def is_zip_code?
    self.length == 5 && self.to_i > 0
  end

  def for_count(cnt)
    1 == cnt.to_i ? self : self.pluralize
  end

  def is_email?
    self.strip.match(/^(.+)@(.+\..+)$/)
  end

end