class Order < ActiveRecord::Base
  belongs_to :user, :class_name => "User"
  has_many   :positions
  has_many   :products, :through => :positions
end
