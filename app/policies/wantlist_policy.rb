class WantlistPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

    def show?
      return true
    end

    def create?
      return true
    end

    def update?
      user_is_owner?
    end

    def destroy?
      user_is_owner?
    end
  end

  private

  def user_is_owner?
    user == record.user
  end
end
