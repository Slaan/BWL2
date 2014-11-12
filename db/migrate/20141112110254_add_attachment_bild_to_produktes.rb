class AddAttachmentBildToProduktes < ActiveRecord::Migration
  def self.up
    change_table :produktes do |t|
      t.attachment :bild
    end
  end

  def self.down
    remove_attachment :produktes, :bild
  end
end
