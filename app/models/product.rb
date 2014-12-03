class Product < ActiveRecord::Base

  # relation between products and other entities
  has_many :productrelations, foreign_key: "super_id"
  has_many :subs,    :through => :productrelations
  has_many :supers,  :through => :productrelations
  
  # through the paperclip gem we're albe to add images
  # here we decide which format our image has, where it is
  # stored and which url to show im browser
  has_attached_file :picture, 
          :styles       => { :larger => '400x400>', :medium => "200x200>",
                             :thumb  => "100x100>" }, 
          :default_url  => ":rails_root/public/system" +
                           "/:attachment/:id/:style/:filename",
          :url          => "/system/:attachment/:id/:style/:filename"

  # validates makes sure that attributes are
  # present. otherwise our view says that there
  # is something missing :)
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :amount, presence: true
  validates :since, presence: true
  validates :since, presence: true
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  def self.search(product)
    if product
      query = "%#{product}%"
      where("name LIKE ? OR description LIKE ?", query, query)
    else
      all
    end
  end
end
