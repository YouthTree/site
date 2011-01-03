require 'nokogiri'

class SharedSnippetsController < ApplicationController
  no_login_required

  def index
    snippet_names = Radiant::Config['youthtree.shared_snippets'].to_s.split(",")
    snippets      = Snippet.find_all_by_name(snippet_names)
    page          = Page.find_by_path('/')
    
    mapping = snippets.inject({}) do |acc, snippet|
      acc[snippet.name] = normalised_snippet(page, snippet)
      acc
    end
    
    expires_in 10.minutes, :public => true
    render :json => ActiveSupport::JSON.encode(mapping)
  end

  protected
  
  def normalised_snippet(page, snippet)
    doc = Nokogiri::HTML(page.render_snippet(snippet).to_s)
    doc.search('a').each do |link|
      href = link['href'].to_s
      link['href'] = "http://#{request.host}#{href}" if href =~ /^\//
    end
    doc.at('*').to_html.html_safe
  end
  
end
