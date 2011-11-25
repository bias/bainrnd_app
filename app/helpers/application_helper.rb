module ApplicationHelper

  def logo
    image_tag("logo.png", :alt => "Alternate Annosum logo", :class => "round") 
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Annosum"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
