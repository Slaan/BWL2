class CreateBestehtAus < ActiveRecord::Migration
  def change
    create_table :besteht_aus do |t|
      t.integer :ganzes_id, :null => false
      t.integer :teil_id, :null => false
      t.integer :bestandteile
#      t.foreign_key :ganzes, :column => :ganzes_id
#      t.foreign_key :teil, :column => :teil_id

      t.timestamps
    end
  end
end
