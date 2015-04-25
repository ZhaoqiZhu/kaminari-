class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :answer]
  before_action :authenticate_user!
  load_and_authorize_resource
  
  # GET /questions
  # GET /questions.json
  def index
    #@questions = Question.all.sort{|a1, a2| a2.total_votes <=> a1.total_votes}.page params[:page]
    @questions = Question.all.desc(:total_votes, :answers_count, :created_at).page params[:questions_page]
    #@questions = @questions.sort{|a1, a2| a2.total_votes <=> a1.total_votes}
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question.clicks+=1
    @question.save
  end

  def answer
    @question.answers.create(body: params[:answer][:body], author: current_user)
    answer = @question.answers.to_a[@question.answers.length - 1]
    redirect_to question_path(answer.question.id, page: (answer.question.answers.desc(:votes, :created_at).to_a.index(answer) / Answer.default_per_page + 1), anchor: answer.id), notice: 'Answer was successfully created'
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.author = current_user
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :body)
    end
end
