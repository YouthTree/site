class CreateImageCollections < ActiveRecord::Migration
  def self.up
    create_table :image_collections do |t|
      t.string :title
      t.timestamps
    end
    add_index :image_collections, ['title']
  end

  def self.down
    drop_table :image_collections
  end
end
