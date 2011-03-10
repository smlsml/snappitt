class MomentComment < Comment

  belongs_to :moment, :inverse_of => :comments

end