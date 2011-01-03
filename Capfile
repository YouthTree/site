[:settings, :jammit, :compass, :barista].each do |feature|
  set feature, false
end

set :uploads_latest,  'public/images/uploaded'
set :application,     'site'
set :rvm_ruby_string, 'ree@youthtree_site'

set :git_enable_submodules, true

require 'youthtree-capistrano'

namespace :session do
  
  set :session_config_file_name, 'session.yml'
  set(:session_shared_config) { session_config_file_name }
  set(:session_latest_config) { "config/#{session_config_file_name}" }
  
  desc "Create an empty sessions config"
  task :setup do
    run "touch '#{shared_path}/#{session_shared_config}'"
  end
  
  desc "Symlinks the session.yml into place"
  task :symlink do
    symlink_config session_shared_config, session_latest_config
  end
  
end

after 'deploy:setup',       'session:setup'
after 'deploy:update_code', 'session:symlink'