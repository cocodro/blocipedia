class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    record.public? || user.premium? || user.admin?
  end

  class Scope
    attr_reader :user, :scope
    def initialize(user,scope)
      @user = user
      @scope = scope
    end
    def resolve
      if user.admin?
        scope.all
      elsif user.premium?
        scope.where(private: false, user: user)
      else
        scope.where(private: false)
      end
    end
  end
end
