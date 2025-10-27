class UserResult < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire

  before_create :set_submitted_at

  private

  def set_submitted_at
    self.submitted_at = Time.current
  end
end
