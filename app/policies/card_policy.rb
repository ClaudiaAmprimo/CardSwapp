class CardPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

    def index?
      true
    end

    def show?
      true
    end

    def add_to_wantlist?
      user.present?
    end

  end
end
