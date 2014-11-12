class Produkte < ActiveRecord::Base

  def  self.search(query)
    if query
      where("name LIKE ?", "%#{query}%")
    else
      all
    end
  end

  has_attached_file :bild, 
          :styles => { :larger => '400x400', :medium => "200x200>", :thumb => "100x100>" },      
          :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
          :url => "/system/:attachment/:id/:style/:filename"
end
