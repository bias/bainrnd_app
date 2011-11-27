module ApplicationHelper

  def logo
    image_tag("logo.png", :alt => "Alternate Bain RnD logo", :class => "round") 
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Bain RnD"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
