module RadiantYouthtreeExtension
  module Tags
    
    include Radiant::Taggable
    include ActionView::Helpers::TagHelper
    
    
    desc %{
      Generates an hinted html tag., including classes.
      
      All attributes are passed through.
    }
    tag 'html' do |tag|
      attrs = tag.attr.stringify_keys
      output = ""
      output << "<!--[if lt IE 7 ]> #{ tag(:html, css_class('ie6', attrs)) } <![endif]-->\n"
      output << "<!--[if IE 7 ]>    #{ tag(:html, css_class('ie7', attrs)) } <![endif]-->\n"
      output << "<!--[if IE 8 ]>    #{ tag(:html, css_class('ie8', attrs)) } <![endif]-->\n"
      output << "<!--[if IE 9 ]>    #{ tag(:html, css_class('ie9', attrs)) } <![endif]-->\n"
      output << "<!--[if (gt IE 9)|!(IE)]><!-->\n"
      output << content_tag(:html, "<!--<![endif]-->\n#{tag.expand}\n".html_safe, attrs)
      output
    end
    
    desc %{
      Generates a subsections container.
    }
    tag 'subsections' do |tag|
      content_tag :div, tag.expand, css_class('subsection-container', tag.attr)
    end
    
    desc %{
      Generates a subsection, taking a title as the required attributes.
    }
    tag 'subsection' do |tag|
      title = tag.attr.delete 'title'
      links = %w(true links).include?(tag.attr.delete('links'))
      
      tag_inner = tag.expand.html_safe
      tag_inner = content_tag(:ul, tag_inner, :class => 'section-links') if links
      inner = content_tag(:h3, title.to_s)
      inner << tag_inner
      content_tag(:div, inner, css_class('subsection', tag.attr))
    end
    
    desc %{
      Generals a link embedded in a li. Takes standard a tag options.
      
      Named as they're generally used for menu links.
    }
    tag 'ml' do |tag|
      content_tag(:li, content_tag(:a, tag.expand.html_safe, tag.attr))
    end

    def css_class(klass, options)
      options.merge 'class' => [options['class'], klass].join(' ').squeeze(' ').strip
    end
    
  end
end