class AnswersController < ApplicationController
  respond_to :html, :js

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  # def show
  #   @answer = Answer.find(params[:id])

  #   # respond_to do |format|
  #   #   format.html # show.html.erb
  #   #   format.json { render json: @answer }
  #   # end
  # end

  # GET /answers/new
  # GET /answers/new.json
  # def new
  #   @answer = Answer.new

  #   # respond_to do |format|
  #   #   format.html # new.html.erb
  #   #   format.json { render json: @answer }
  #   # end
  # end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
    # render partial: 'form', locals: {answer: @answer}
    respond_with( @answer, :layout => !request.xhr? )
  end

  # POST /answers
  # POST /answers.json
  def create
    params[:answer][:question] = Question.find(params[:answer][:question_id])
    params[:answer].delete :question_id
    @answer = current_user.answers.create(params[:answer])
    respond_with( @answer, :layout => !request.xhr? )
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    @answer = Answer.find(params[:id])
    params[:answer].delete :question_id

    if @answer.update_attributes(params[:answer])
      respond_to do |format|
        format.html do
          if request.xhr?
            render partial: 'answers/answer',
                   locals: { answer: @answer },
                   layout: false,
                   status: :created
          else
            redirect_to @answer.question
          end
        end
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html do
          if request.xhr?
            render json: @answer.errors, status: :unprocessable_entity
          else
            render action: "edit", id: @answer
          end
        end
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    respond_with(@answer) do |format|
      format.js { render layout: false }
    end
  end
end
