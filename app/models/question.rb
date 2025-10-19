class Question < ApplicationRecord
  belongs_to :questionnaire

  has_many :question_options, dependent: :destroy

  accepts_nested_attributes_for :question_options,
                                reject_if: :all_blank,
                                allow_destroy: true
end
