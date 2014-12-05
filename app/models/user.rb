class User < ActiveRecord::Base
  
  # relations 
  # user <-> product
  has_many :basketposition
  has_many :products, :through => :basketposition


  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save {self.email = email.downcase}
  validates :name, presence: true
  
  validates :email, presence: true, 
                             format: { with: VALID_EMAIL_REGEX } 

  has_secure_password
end
