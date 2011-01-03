class SharedSnippetsController < ApplicationController
  no_login_required

  def index
    snippet_names = Radiant::Config['youthtree.shared_snippets'].to_s.split(",")
    snippets      = Snippet.find_all_by_name(snippet_names)
    page          = Page.find_by_path('/')
    
    mapping = snippets.inject({}) do |acc, snippet|
      acc[snippet.name] = page.render_snippet(snippet)
      acc
    end
    
    expires_in 10.minutes, :public => true
    render :json => ActiveSupport::JSON.encode(mapping)
  end
end
