class ReactionsController < ApplicationController

  respond_to :html, :xml, :js, :json

  # GET /reactions
  # GET /reactions.json
  # def index
  #   @reactions = Reaction.find_all_by_article_id(params[:article_id])

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @reactions }
  #   end
  # end

  # GET /reactions/1
  # GET /reactions/1.json
  # def show
  #   @reaction = Reaction.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @reaction }
  #   end
  # end

  # GET /reactions/new
  # GET /reactions/new.json
  def new
    @reaction = current_user.reactions.build
    @reaction.article = Article.find_by_id(params[:article_id])

    respond_with(@reaction, layout: !request.xhr?)
  end

  # GET /reactions/1/edit
  def edit
    @reaction = Reaction.find(params[:id])
    respond_with( @reaction, :layout => !request.xhr? )
  end

  # POST /reactions
  # POST /reactions.json
  def create
    params[:reaction][:article] = Article.find(params[:reaction][:article_id])
    params[:reaction].delete :article_id

    @reaction = current_user.reactions.new(params[:reaction])

    if @reaction.save
      respond_to do |format|
        format.html do
          if request.xhr?
            render partial: 'reactions/show',
                   locals: { reaction: @reaction },
                   layout: false,
                   status: :created
          else
            redirect_to @reaction.article
          end
        end
      end
    else
      respond_to do |format|
        format.html do
          if request.xhr?
            render json: @reaction.errors, status: :unprocessable_entity
          else
            render template: 'articles/show', id: @reaction.article_id
          end
        end
      end
    end

    # respond_to do |format|
    #   if @reaction.save
    #     format.html { redirect_to @reaction, notice: 'Reaction was successfully created.' }
    #     format.json { render json: @reaction, status: :created, location: @reaction }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @reaction.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /reactions/1
  # PUT /reactions/1.json
  def update
    @reaction = Reaction.find(params[:id])
    params[:reaction].delete :article_id

    #respond_to do |format|
    #  if @reaction.update_attributes(params[:reaction])
    #    format.html { redirect_to @reaction.article, notice: 'Reaction was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @reaction.errors, status: :unprocessable_entity }
    #  end
    #end

    if @reaction.update_attributes(params[:reaction])
      respond_to do |format|
        format.html do
          if request.xhr?
            render partial: 'reactions/show',
                   locals: { reaction: @reaction },
                   layout: false,
                   status: :created
          else
            redirect_to @reaction.article
          end
        end
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html do
          if request.xhr?
            render json: @reaction.errors, status: :unprocessable_entity
          else
            render action: "edit", id: @reaction
          end
        end
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reactions/1
  # DELETE /reactions/1.json
  def destroy
    @reaction = Reaction.find(params[:id])
    @reaction.destroy

    if @reaction.destroyed?
      respond_to do |format|
        format.html do
          if request.xhr?
            render nothing: true, status: :no_content
          else
            redirect_to @reaction.article
          end
        end
      end
    else
      respond_to do |format|
        format.html do
          if request.xhr?
            render json: @reaction.errors, status: :unprocessable_entity
          else
            render template: 'articles/show', id: @reaction.article_id
          end
        end
      end
    end

    # respond_to do |format|
    #   format.html { redirect_to @reaction.article }
    #   format.json { head :no_content }
    # end
  end
end
