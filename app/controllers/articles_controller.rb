class ArticlesController < ApplicationController
  before_filter :authenticate_user!
  # GET /articles
  # GET /articles.json
  def index
    @title = 'Articles'

    @articles = if params[:project_id]
      Article.find_all_by_project_id(params[:project_id])
    else
      @articles = Article.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @title = "Article: #{@article.title}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /project/:id/articles/new
  # GET /project/:id/articles/new.json
  def new
    @article = Article.new
    @project_id = params[:id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @title = 'Edit article'
    @article = Article.find(params[:id])
    @project_id = @article.project_id
    authorize! :manage, @article
  end

  # POST /articles
  # POST /articles.json
  def create
    params[:article][:project] = Project.find(params[:article][:project_id])
    params[:article].delete :project_id
    @article = current_user.articles.new(params[:article])
    authorize! :create, @article
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    params[:article].delete :project_id
    authorize! :manage, @article
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    authorize! :manage, @article
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
