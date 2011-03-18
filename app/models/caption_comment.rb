class CaptionComment < Comment

  has_one :moment#, :inverse_of => :caption

  def to_s
    text
  end

end