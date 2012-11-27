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

  def markdown(text)
    rndr = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = [:no_intra_emphasis, :fenced_code_blocks, :autolink].inject({}) do |mem, var|
      mem[var] = true
      mem
    end
    md = Redcarpet::Markdown.new(rndr, options)
    raw md.render(text)
  end
end
