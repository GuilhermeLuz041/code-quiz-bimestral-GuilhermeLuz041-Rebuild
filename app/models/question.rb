class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :question_options, dependent: :destroy
  has_many :user_answer_histories, dependent: :destroy

  validates :enunciation, presence: true
  validate :has_at_least_one_correct_option

  accepts_nested_attributes_for :question_options,
                              reject_if: :all_blank,
                              allow_destroy: true

  def correct_option
    question_options.find_by(is_correct: true)
  end

  private

  def has_at_least_one_correct_option
    return if question_options.any?(&:is_correct?)
    errors.add(:base, "Deve haver pelo menos uma opção correta")
  end
end
