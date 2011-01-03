class YouthtreeExtension < Radiant::Extension
  version "0.0.1"
  description "Generic Youthtree Features"
  url "http://youthtree.org.au"
  
  extension_config do |config|
    require 'radiant-youthtree-extension/tags'
  end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    Page.send :include, RadiantYouthtreeExtension::Tags
  end
end
