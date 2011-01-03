class ImageCollectionEntry < ActiveRecord::Base
  
  belongs_to :image_collection
  belongs_to :image
  
end
