class QuestionOptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :set_question_option, only: %i[ show edit update destroy ]

  # GET /question_options or /question_options.json
  def index
    @question_options = QuestionOption.all
  end

  # GET /question_options/1 or /question_options/1.json
  def show
  end

  # GET /question_options/new
  def new
    @question_option = @question.question_options.build
    authorize @question_option
  end

  # GET /question_options/1/edit
  def edit
    authorize @question_option
  end

  # POST /question_options or /question_options.json
  def create
    @question_option = @question.question_options.build(question_option_params)
    authorize @question_option

    if @question_option.save
      redirect_to @question, notice: "Opção criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /question_options/1 or /question_options/1.json
  def update
    authorize @question_option
    if @question_option.update(question_option_params)
      redirect_to @question, notice: "Opção atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /question_options/1 or /question_options/1.json
  def destroy
    authorize @question_option
    @question_option.destroy!
    redirect_to @question, notice: "Opção destruída com sucesso."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_option
      @question_option = QuestionOption.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def question_option_params
      params.expect(question_option: [:title, :is_correct])
    end
end
