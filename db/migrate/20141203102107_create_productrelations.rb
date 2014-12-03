class CreateProductrelations < ActiveRecord::Migration
  def change
    create_table :productrelations do |t|
      t.integer :amount
      t.integer "super_id"
      t.integer "sub_id"

      t.timestamps
    end
  end
end
