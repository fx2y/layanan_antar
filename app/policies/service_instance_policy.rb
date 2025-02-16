class ServiceInstancePolicy < ApplicationPolicy
  attr_reader :user_context, :record

  def initialize(user_context, record)
    @user_context = user_context
    @record = record
  end

  def index?
    return true if user.master_admin?
    return false unless user.mitra_admin?
    user.mitra_admin_for?(mitra)
  end

  def show?
    user.master_admin? || user.mitra_admin_for?(record.mitra)
  end

  def create?
    user.master_admin? || user.mitra_admin_for?(record.mitra)
  end

  def update?
    user.master_admin? || user.mitra_admin_for?(record.mitra)
  end

  def destroy?
    user.master_admin? || user.mitra_admin_for?(record.mitra)
  end

  class Scope
    attr_reader :user_context, :scope

    def initialize(user_context, scope)
      @user_context = user_context
      @scope = scope
    end

    def resolve
      if user.master_admin?
        scope.all
      else
        scope.where(mitra: user.administered_mitras)
      end
    end

    private

    def user
      user_context[:user]
    end
  end

  private

  def user
    user_context[:user]
  end

  def mitra
    user_context[:mitra]
  end
end
