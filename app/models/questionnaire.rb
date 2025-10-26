class Questionnaire < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :user_answer_histories
  has_many :user_results

  scope :active, -> { where(deleted_at: nil) }
  
  def destroy
    update(deleted_at: Time.current)
    questions.destroy_all
  end
end
