class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  validates :title, presence: true, uniqueness: true,
            inclusion: { in: %w[admin moderator student] }

  scope :admin_role, -> { find_by(title: 'admin') }
  scope :moderator_role, -> { find_by(title: 'moderator') }
  scope :student_role, -> { find_by(title: 'student') }
end
