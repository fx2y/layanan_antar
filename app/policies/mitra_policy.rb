class MitraPolicy < ApplicationPolicy
  def index?
    user.master_admin?
  end

  def show?
    user.master_admin? || user.mitra_admin_for?(record)
  end

  def create?
    true # Public registration, but consider CAPTCHA
  end

  def update?
    user.master_admin? || user.mitra_admin_for?(record)
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
