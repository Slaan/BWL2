class CreateProduktes < ActiveRecord::Migration
  def change
    create_table :produktes do |t|
      t.string :name
      t.string :beschreibung
      t.integer :preis
      t.integer :stueckzahl
      t.date :datumvon
      t.date :datumbis

      t.timestamps
    end
  end
end
