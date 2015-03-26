class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    record.public? || user.premium? || user.admin?
  end

  class Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.premium?
        scope.eager_load(:collaborators).where("wikis.private = ? OR wikis.user_id = ? OR collaborators.user_id = ?", false, user.id, user.id)
      else
        scope.eager_load(:collaborators).where("wikis.private = ? OR collaborators.user_id = ?", false, user.id)
      end
    end
  end
end
