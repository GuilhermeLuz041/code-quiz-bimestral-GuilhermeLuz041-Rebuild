class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = policy_scope(@questionnaire.questions)
  end

  def show
    authorize @question
  end

  def new
    @question = @questionnaire.questions.build
    2.times { @question.question_options.build }
    authorize @question
  end

  def edit
    authorize @question
  end

  def create
    @question = @questionnaire.questions.build(question_params)
    authorize @question

    if @question.save
      redirect_to @questionnaire, notice: "Pergunta criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @question

    if @question.update(question_params)
      redirect_to @questionnaire, notice: "Pergunta atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @question
    @question.destroy!
    redirect_to @questionnaire, notice: "Pergunta excluída com sucesso."
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :enunciation,
      question_options_attributes: [:id, :title, :is_correct, :_destroy]
    )
  end
end
