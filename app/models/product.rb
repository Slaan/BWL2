class Product < ActiveRecord::Base

  # relation between products and other entities
  # product <-> product 
  has_many :productrelations, foreign_key: "super_id"
  has_many :subs,    :through => :productrelations
  has_many :supers,  :through => :productrelations

  # product <-> user
  has_many :users,   :through => :basketpositions

  has_many :positions
  has_many :orders, :through => :positions

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
  validates_presence_of :name, :description, :price, :amount, :since, :until
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  def self.search(product)
    if product
      query = "%#{product}%"
      where("name LIKE ? OR description LIKE ?", query, query)
    else
      all
    end
  end

  # arithmetical middle for the last three months
  def arithmetical_middle(n = 2)
    months = (0..n).reduce([]) { |accu, elem| 
      accu << elem.months.ago.month
    }
    positions.reduce(0) do |accu, elem| 
      if elem.order.date.month.in?(months) then 
        accu += elem.amount 
      else 
        accu 
      end
    end / n
  end

  def exponential_smoothing(alpha = 0.2)
     
  end

end
