ActionController::Routing::Routes.draw do |map|
  # map.namespace :admin, :member => { :remove => :get } do |admin|
  #   admin.resources :youthtree
  # end
  
  map.shared_snippet '/snippets.json', :controller => 'shared_snippets', :action => 'index'
  
end