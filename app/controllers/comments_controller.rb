class CommentsController < ApplicationController
  before_filter :authenticate_user!
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
    authorize! :manage, @comment
    if params.has_key? :reaction_id
      @comment.commentable = Reaction.find_by_id(params[:reaction_id].to_i)
    else  
      @comment.commentable = Answer.find_by_id(params[:answer_id].to_i)
    end
    respond_with(@comment, layout: !request.xhr?)
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    authorize! :manage, @comment
    respond_with(@comment, layout: !request.xhr?)
  end

  # POST /comments
  # POST /comments.json
  def create
    if params[:comment].has_key? :reaction_id
      params[:comment][:commentable] = Reaction.find_by_id(params[:comment][:reaction_id])
      params[:comment].delete :reaction_id
    else 
      params[:comment][:commentable] = Answer.find_by_id(params[:comment][:answer_id])
      params[:comment].delete :answer_id
    end   

    # params[:comment][:commentable] = Reaction.find_by_id(params[:comment][:commentable_id])
    # params[:comment].delete :commentable_id

    @comment = current_user.comments.new(params[:comment])
    authorize! :manage, @comment
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
    authorize! :manage, @comment
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
    authorize! :manage, @comment
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
