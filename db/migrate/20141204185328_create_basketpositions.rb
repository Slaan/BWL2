class CreateBasketpositions < ActiveRecord::Migration
  def change
    create_table :basketpositions do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :how_many

      t.timestamps
    end
  end
end
