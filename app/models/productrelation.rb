# Productrelation is our recusive definition
# for the quantity of products
class Productrelation < ActiveRecord::Base

  # tell rails that each productrelation
  # has a super type and sub type. when one of
  # them is nil, we know there is no parent/child
  belongs_to :super, :class_name => "Product"
  belongs_to :sub,   :class_name => "Product"

  validates :amount, presence: true 
end
