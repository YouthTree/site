class ImageCollection < ActiveRecord::Base
  
  validates_presence_of :title
  
  has_many :entries, :class_name => "ImageCollectionEntry"
  has_many :images, :through => :entries
  
end
