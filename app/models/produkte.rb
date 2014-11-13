class Produkte < ActiveRecord::Base
  
  # relational
  # belongs_to: :produkte, :through => :besteht_auss
  has_many :besteht_auss
  has_many :produktes, through: :besteht_auss
  has_many :produktes, through: :besteht_auss

  # functional
  def  self.search(query)
    if query
      where("name LIKE ?", "%#{query}%")
    else
      all
    end
  end

  # attributes
  has_attached_file :bild, 
          :styles => { :larger => '400x400>', :medium => "200x200>", :thumb => "100x100>" },      
          :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
          :url => "/system/:attachment/:id/:style/:filename"

   validates_attachment_content_type :bild, :content_type => /\Aimage\/.*\Z/
end
