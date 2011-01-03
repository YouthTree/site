# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
class ImageCollectionExtension < Radiant::Extension
  version     "0.0.1"
  description "Adds collections to the images extension"
  url "http://youthtree.org.au"
  
  # extension_config do |config|
  #   config.gem 'some-awesome-gem
  #   config.after_initialize do
  #     run_something
  #   end
  # end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    return
    tab 'Content' do
      add_item "Image Collections", "/admin/image_collections", :after => "Images"
    end
  end
end
