class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :questionnaires, dependent: :destroy

  after_create :assign_default_role

  def has_role?(role_title)
    roles.exists?(title: role_title)
  end

  def admin?
    has_role?('admin')
  end

  def moderator?
    has_role?('moderator')
  end

  def student?
    has_role?('student')
  end

  def promote_to_moderator
    return false if moderator? || !Role.exists?(title: 'moderator')
    roles << Role.find_by(title: 'moderator')
    true
  end

  def demote_from_moderator
    return false unless moderator?
    user_roles.joins(:role).where(roles: { title: 'moderator' }).destroy_all
    true
  end

  private

  def assign_default_role
    student_role = Role.find_by(title: 'student')
    roles << student_role if student_role && !roles.include?(student_role)
  end
end
