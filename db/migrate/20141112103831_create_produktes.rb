class CreateProduktes < ActiveRecord::Migration
  def change
    create_table :produktes do |t|
      t.string :name, :null => false
      t.string :beschreibung
      t.integer :preis, :null => false
      t.integer :stueckzahl, :null => false
      t.date :datumvon
      t.date :datumbis

      t.timestamps
    end
  end
end
