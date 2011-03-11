class Connection < ActiveRecord::Base

  belongs_to :to, :class_name => "User", :foreign_key => 'user_id_to'
  belongs_to :from, :class_name => "User", :foreign_key => 'user_id_from'

  validate :not_self
  validates_uniqueness_of :user_id_from, :scope => :user_id_to
  validates_uniqueness_of :user_id_to, :scope => :user_id_from

  protected

  def not_self
    errors.add_to_base('Can not follow self') if user_id_to == user_id_from
  end

end
