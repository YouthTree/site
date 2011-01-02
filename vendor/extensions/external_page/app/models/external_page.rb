class ExternalPage < Page
  
  description "Links to an external page / another site."
  
  def path
    (field('url').presence || field('Url').presence).try(:content) || '#'
  end
  alias :url :path
  
end