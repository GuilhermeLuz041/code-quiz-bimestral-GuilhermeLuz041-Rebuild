class QuestionnairePolicy < ApplicationPolicy
  # A classe Scope é apenas para a ação 'index' (listagem)
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
  
  def show?
    true
  end

  def create?
    user.admin? || user.moderator?
  end

  def new?
    create?
  end

  def update?
    user.admin? || record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end