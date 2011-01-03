class CreateImageCollectionEntries < ActiveRecord::Migration
  def self.up
    create_table :image_collection_entries do |t|
      t.belongs_to :image
      t.belongs_to :image_collection

      t.timestamps
    end
    add_index :image_collection_entries, ['image_collection_id']
    add_index :image_collection_entries, ['image_id', 'image_collection_id']
  end

  def self.down
    drop_table :image_collection_entries
  end
end
