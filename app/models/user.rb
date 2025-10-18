class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :questionnaires, dependent: :destroy

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

end
