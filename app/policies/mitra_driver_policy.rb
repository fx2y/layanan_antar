class MitraDriverPolicy < ApplicationPolicy
  def index?
    user.master_admin? || user.mitra_admin_for?(record.mitra)
  end

  def show?
    user.master_admin? || user.mitra_admin_for?(record.mitra)
  end

  def create?
    user.master_admin? || user.mitra_admin_for?(record.mitra)
  end

  def destroy?
    user.master_admin? || user.mitra_admin_for?(record.mitra)
  end

  class Scope < Scope
    def resolve
      if user.master_admin?
        scope.all
      else
        scope.where(mitra: user.administered_mitras)
      end
    end
  end
end
