class CollectionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

    def new?
      # user.present?
      user.present?.tap { |result| Rails.logger.debug("Authorization result: #{result}") }
    end

    def show?
      true
    end

    def create?
      # return true
      user.present?
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
