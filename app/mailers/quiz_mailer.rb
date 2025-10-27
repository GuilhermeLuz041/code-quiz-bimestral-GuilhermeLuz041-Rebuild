class QuizMailer < ApplicationMailer
  def quiz_result(user_result)
    @user = user_result.user
    @result = user_result
    @questionnaire = user_result.questionnaire
    
    mail(
      to: @user.email,
      subject: "Resultado do Quiz: #{@questionnaire.title}"
    )
  end
end