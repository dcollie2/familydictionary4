module ApplicationHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    content_for :title do
      @content_for_title
    end
    @show_title = show_title
  end

  def description(description = "An Abbreviated Family Dictionary")
    @description = strip_tags(description)
  end

  def show_title?
    @show_title
  end

  def icon(icon, options = {})
    file = File.read("node_modules/bootstrap-icons/icons/#{icon}.svg")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] += " " + options[:class]
    end
    doc.to_html.html_safe
  end


end
