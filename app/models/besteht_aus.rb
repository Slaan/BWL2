class BestehtAus < ActiveRecord::Base
  belongs_to :ganzes, 
              :class_name => 'Produkte', :foreign_key => 'ganzes_id' 
  belongs_to :teil, 
              :class_name => 'Produkte', :foreign_key => 'teil_id'
end
