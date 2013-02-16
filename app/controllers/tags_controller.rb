class TagsController < ApplicationController
  # GET /tags/:tag
  def index
    @tag = params[:tag]

    @title = "Tagged with \"#{@tag}\""

    @tagged = {}
    @tagged[:projects]  = Project.tagged_with(@tag)
    @tagged[:questions] = Question.tagged_with(@tag)
    @tagged[:articles]  = Article.tagged_with(@tag)

    #  render partial: 'tagged', layout: 'application'
    #else
    @tags = ActsAsTaggableOn::Tag.find_by_sql('select distinct tags.name from tags inner join taggings on taggings.tag_id = tags.id where taggings.context = \'tags\'')
  end
end
