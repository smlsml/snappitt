class String

  def possessive
    self.last == 's' ? (self + "\'") : (self + "\'s")
  end

  def is_zip_code?
    self.length == 5 && self.to_i > 0
  end

end