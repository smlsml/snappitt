class Connection < ActiveRecord::Base

  belongs_to :to, :class_name => "User", :foreign_key => 'user_id_to'
  belongs_to :from, :class_name => "User", :foreign_key => 'user_id_from'

end
