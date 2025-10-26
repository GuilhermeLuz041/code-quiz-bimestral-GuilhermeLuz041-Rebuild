class RenameSelectedOptionToQuestionOptionInUserAnswerHistories < ActiveRecord::Migration[8.0]
  def change
    rename_column :user_answer_histories, :selected_option_id, :question_option_id
  end
end
