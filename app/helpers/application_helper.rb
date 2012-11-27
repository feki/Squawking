require 'net/http'
require 'uri'
require 'nokogiri'

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

    raw Redcarpet::Render::SmartyPants.render(highlight_syntax(md.render(text)).to_s)
  end

  PYGMENTS_URI = 'http://pygments.appspot.com/'

  def highlight_syntax(html)

    doc = Nokogiri::HTML(html)
    doc.search("pre > code[class]").each do |code|
      request = Net::HTTP.post_form(URI.parse(PYGMENTS_URI), 
                  { 'lang' => code[:class],
                    'code' => code.text.rstrip })
      code.parent.replace request.body
    end

    doc.search("//body").children.to_s
  end
end
