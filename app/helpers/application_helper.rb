module ApplicationHelper
  def app_name
    "SquawKING"
  end

  # Return a title on a per-page basis.
  def title
    base_title = app_name 
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
