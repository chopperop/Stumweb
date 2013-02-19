module ApplicationHelper
	# Return a title on a per-page basis.
def title
   	base_title = "Stumweb: the front page of New York City!"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
