class CaptionComment < Comment

  has_one :moment#, :inverse_of => :caption

  def to_s
    text
  end

  def html_quoted
    return '' if text.strip.blank?
    '&ldquo;'.html_safe << text << '&rdquo;'.html_safe
  end

end