class QuestionPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user.admin? || record.questionnaire.user == user
  end

  def new?
    create?
  end

  def update?
    user.admin? || record.questionnaire.user == user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end