module ImageEmbedding
  module Tags
    module Core
      
      include Radiant::Taggable
      include ActionView::Helpers::TagHelper
      
      desc %{
        Renders an inline image (for using in paragraphs), taking a given title.
        
        *Usage:*
        <pre><code><r:image:inline title='something' /></code></pre>
        
        * @title@ - The required title of the image.
        * @style@ - The style of the image, defaults to original.
        
        * @id@, @class@,..: go as html attributes of the outer ul
      }
      tag "image:inline" do |tag|
        title = tag.attr.delete("title")
        return if title.blank?
        style = tag.attr.delete("style").presence || "original"
        
        image = Image.find_by_title(title)
        return if image.blank?
        
        html_options = tag.attr.stringify_keys
        
        html_options['src'] = image.url(style)
        html_options['alt'] = html_options['alt'].presence || image.caption.presence || image.title
        
        options = tag_options(html_options)
        
        "<img#{options}/>"
      end
      
      desc %{
        Renders an image with a caption, taking a given title.
        
        *Usage:*
        <pre><code><r:image:container title='something' /></code></pre>
        
        * @title@ - The required title of the image.
        * @style@ - The style of the image, defaults to original.
        * @caption@ - If present, sets the caption for the page.
        * @hide_caption@ - If true, will hide the caption
        
        * @id@, @class@,..: go as html attributes of the outer ul
      }
      tag "image:container" do |tag|
        title = tag.attr.delete("title")
        return if title.blank?
        style = tag.attr.delete("style").presence || "original"
        
        image = Image.find_by_title(title)
        return if image.blank?
        
        hide_caption = %w(hide_caption true).include?(tag.attr.delete('hide_caption'))
        caption = tag.attr.delete('caption').presence || image.caption.presence || image.title
        
        html_options = tag.attr.stringify_keys
        
        html_options['src'] = image.url(style)
        html_options['alt'] = html_options['alt'].presence || image.caption.presence || image.title
        
        options = tag_options(html_options)
        
        tag = "<div class='image-container'>"
        tag << "<img#{options}/>"
        
        unless hide_caption || caption.blank?
          tag << "<p>#{caption}</p>"
        end
        
        tag << '</div>'
        tag
      end
      
      desc %{
        Returns a ranged list of images.
        
        *Usage:*
        <pre><code><r:image:list prefix="something-" from="a" to="c" /></code></pre>
        
        * @prefix@ - Name prefix
        * @from@ - Start value
        * @to@ - End value
      }
      tag 'image:list' do |tag|
        return if %w(from to prefix).any? { |i| tag.attr[i].blank? }
        range = (tag.attr['from']..tag.attr['to'])
        prefix = tag.attr['prefix']
        images = Image.all(:conditions => ['title like ?', "#{prefix}%"]).inject({}) do |acc, current|
          acc.merge current.title => current
        end
        inner = ""
        range.each do |current|
          image = images["#{prefix}#{current}"]
          if image.present?
            tag.locals.image = image
            inner << content_tag(:li, tag.expand)
            tag.locals.image = nil
          end
        end
        content_tag :ul, inner
      end
      
    end
  end
end