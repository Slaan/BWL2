class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :amount
      t.integer :price

      t.timestamps
    end
  end
end
