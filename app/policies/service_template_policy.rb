class ServiceTemplatePolicy < ApplicationPolicy
  def index?
    user.master_admin?
  end

  def show?
    user.master_admin?
  end

  def create?
    user.master_admin?
  end

  def update?
    user.master_admin?
  end

  def destroy?
    user.master_admin?
  end

  class Scope < Scope
    def resolve
      if user.master_admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
