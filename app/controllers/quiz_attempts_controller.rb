class QuizAttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire

  def show
    @question = @questionnaire.questions.find(params[:id])
    @user_answer = UserAnswerHistory.new
  end

  def submit_answer
    answered_question = @questionnaire.questions.find(params[:id])
    selected_option = answered_question.question_options.find_by(id: params[:selected_option_id])

    unless selected_option
      flash[:alert] = "Você precisa selecionar uma resposta."
      redirect_to questionnaire_quiz_question_path(@questionnaire, answered_question) and return
    end

    UserAnswerHistory.create!(
      user: current_user,
      questionnaire: @questionnaire,
      question: answered_question,
      question_option: selected_option,
      is_correct: selected_option.is_correct,
      answered_at: Time.current
    )

    next_question = find_next_question(answered_question)

    if next_question
      redirect_to questionnaire_quiz_question_path(@questionnaire, next_question)
    else
      finalize_quiz
      redirect_to questionnaire_quiz_result_path(@questionnaire)
    end
  end

  def result
    @user_result = UserResult.where(user: current_user, questionnaire: @questionnaire)
                           .order(submitted_at: :desc)
                           .first!
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
  end

  def find_next_question(current_question)
    ordered_questions = @questionnaire.questions.order(:created_at)
    current_index = ordered_questions.index(current_question)
    ordered_questions[current_index + 1]
  end

  def finalize_quiz
    recent_answers = @questionnaire.questions.map do |question|
      UserAnswerHistory.where(user: current_user, 
                            questionnaire: @questionnaire,
                            question: question)
                      .order(created_at: :desc)
                      .first
    end.compact

    correct_answers = recent_answers.count { |answer| answer.is_correct }
    total_questions = @questionnaire.questions.count
    score = calculate_score(correct_answers, total_questions)

    UserResult.create!(
      user: current_user,
      questionnaire: @questionnaire,
      correct_answers: correct_answers,
      total_questions: total_questions,
      score: score,
      submitted_at: Time.current
    )
  end

  def calculate_score(correct_answers, total_questions)
    total_questions.positive? ? (correct_answers.to_f / total_questions) * 100 : 0
  end
end