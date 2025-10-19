class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions or /questions.json
  def index
    @questions = policy_scope(@questionnaire.questions)
  end

  # GET /questions/1 or /questions/1.json
  def show
    authorize @question
  end

  # GET /questions/new
  def new
    @question = @questionnaire.questions.build
    2.times { @question.question_options.build } 
    authorize @question
  end

  # GET /questions/1/edit
  def edit
    authorize @question
  end

  # POST /questions or /questions.json
  def create
    @question = @questionnaire.questions.build(question_params)
    authorize @question

    if @question.save
      redirect_to @questionnaire, notice: "Pergunta criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    authorize @question
    if @question.update(question_params)
      redirect_to @questionnaire, notice: "Pergunta atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    authorize @question
    @question.destroy!
    redirect_to @questionnaire, notice: "Pergunta destruída com sucesso."
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_questionnaire
      @questionnaire = Questionnaire.find(params[:questionnaire_id])
    end

    def set_question
      @question = Question.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(
        :enunciation,
        question_options_attributes: [:id, :title, :is_correct, :_destroy]
      )
    end
end
