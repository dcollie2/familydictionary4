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

end
