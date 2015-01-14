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
  validates_presence_of :name, :description, :price, :amount, :since, :until, :picture
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
  def arithmetical_middle(n = 3)
    months = (1..n).reduce([]) { |accu, elem| 
      accu << elem.months.ago.month
    }
    need(months) / n
  end

  # m     - month
  # alpha - has to be between 0.1 and 0.3
  def exponential_smoothing(m = 0, alpha = 0.2)
    if !(0.1 <= alpha && alpha <= 0.3) then
      raise "alpha isn't between 0.1 and 0.3"
    end
    _exponential_smoothing(m, alpha)
  end

 private
  
  def _exponential_smoothing(m = 0, alpha = 0.2)
    last_month = (m+1).months.ago.month
    b = need(last_month..last_month)
    pb = (m == 12) ? 0 : exponential_smoothing(last_month)
    pb + (alpha * (b - pb))
  end

  def need(m)
    positions.reduce(0) do |accu, pos|
      if pos.order.date.month.in?(m) then
        accu += pos.amount
      else
        accu
      end
    end
  end

end
