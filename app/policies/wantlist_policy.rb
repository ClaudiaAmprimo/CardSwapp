class WantlistPolicy < ApplicationPolicy
  attr_reader :user, :wantlist

  def initialize(user, wantlist)
    @user = user
    @wantlist = wantlist
  end

  def new?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def add_to_wantlist?
    user == wantlist.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_is_owner?
    user == record.user
  end
end
