class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

    def new?
      user.present? 
    end

    def create?
      user.present?
    end

    def destroy?
      user == record.sender || user == record.receiver
    end

    def accept?
      user == record.receiver && record.pending?
    end

    def reject?
      user == record.receiver && record.pending?
    end
  end
end
