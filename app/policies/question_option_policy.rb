class QuestionOptionPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin? || record.question.questionnaire.user == user
  end

  def new?
    create?
  end

  def update?
    user.admin? || record.question.questionnaire.user == user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end