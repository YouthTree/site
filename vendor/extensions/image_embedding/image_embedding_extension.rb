class ImageEmbeddingExtension < Radiant::Extension
  version     "0.0.1"
  description "Adds image embedding to Radiant."
  url         "http://youthtree.org.au/"
  
  def activate
    Page.send :include, ImageEmbedding::Tags::Core
  end
end
