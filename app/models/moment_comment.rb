class MomentComment < Comment

  belongs_to :moment, :inverse_of => :comments, :counter_cache => :comments_count

end