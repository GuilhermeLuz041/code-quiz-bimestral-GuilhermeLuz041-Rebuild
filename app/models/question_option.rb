class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :user_answer_histories, dependent: :destroy

  before_save :ensure_boolean_is_correct

  private

  def ensure_boolean_is_correct
    self.is_correct = ActiveModel::Type::Boolean.new.cast(is_correct)
  end
end
