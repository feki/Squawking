class CommentsController < ApplicationController

  respond_to :html, :xml, :js, :json

  # GET /comments
  # GET /comments.json
  #def index
  #  @comments = Comment.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @comments }
  #  end
  #end

  # GET /comments/1
  # GET /comments/1.json
  #def show
  #  @comment = Comment.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @comment }
  #  end
  #end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = current_user.comments.build
    @comment.commentable = Reaction.find_by_id(params[:reaction_id].to_i)

    respond_with(@comment, layout: !request.xhr?)
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    respond_with(@comment, layout: !request.xhr?)
  end

  # POST /comments
  # POST /comments.json
  def create
    params[:comment][:commentable] = Reaction.find_by_id(params[:comment][:commentable_id])
    params[:comment].delete :commentable_id

    @comment = current_user.comments.new(params[:comment])

    if @comment.save
      respond_to do |format|
          format.html do
            if request.xhr?
              render partial: "comments/show",
                     locals: { comment: @comment },
                     layout: false,
                     status: :created
            else
              redirect_to @comment.commentable.article
            end
          end
          format.json { render json: @comment, status: :created, location: @comment }
      end
    else
      respond_to do |format|
        format.html do
          if request.xhr?
            render json: @comment.errors, status: :unprocessable_entity
          else
            render template: "articles/show", id: @comment.commentable.article_id
          end
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      respond_to do |format|
        format.html do
          if request.xhr?
            render partial: "comments/show",
                   locals: { comment: @comment },
                   layout: false,
                   status: :created
          else
            redirect_to @comment.commentable.article, notice: 'Comment was successfully updated.'
          end
        end
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html do
          if request.xhr?
            render json: @comment.errors, status: :unprocessable_entity
          else
            render action: "edit", id: @comment.id
          end
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    if @comment.destroyed?
      respond_to do |format|
        format.html do
          if request.xhr?
            render nothing: true, status: :no_content
          else
            redirect_to @comment.commentable.article
          end
        end
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html do
          if request.xhr?
            render json: @comment.errors, status: :unprocessable_entity
          else
            render template: 'articles/show', id: @comment.commentable.article_id
          end
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
