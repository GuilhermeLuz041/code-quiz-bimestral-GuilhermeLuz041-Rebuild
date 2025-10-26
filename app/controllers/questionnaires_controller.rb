class QuestionnairesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire, only: %i[ show edit update destroy ]

  def index
    @questionnaires = policy_scope(Questionnaire).active
  end

  def show
    authorize @questionnaire
  end

  def new
    @questionnaire = Questionnaire.new
    authorize @questionnaire
  end

  def edit
    authorize @questionnaire
  end

  def create
    @questionnaire = current_user.questionnaires.build(questionnaire_params)
    authorize @questionnaire

    if @questionnaire.save
      redirect_to @questionnaire, notice: "Questionário criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @questionnaire

    if @questionnaire.update(questionnaire_params)
      redirect_to @questionnaire, notice: "Questionário atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @questionnaire
    @questionnaire.destroy!
    redirect_to questionnaires_path, notice: "Questionário destruído com sucesso."
  end

  private
    def set_questionnaire
      @questionnaire = Questionnaire.where(deleted_at: nil).find(params[:id])
    end

    def questionnaire_params
      params.require(:questionnaire).permit(:code, :title, :description, :duration_minutes)
    end
end