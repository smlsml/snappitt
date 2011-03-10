class CaptionComment < Comment

  has_one :moment#, :inverse_of => :caption

end