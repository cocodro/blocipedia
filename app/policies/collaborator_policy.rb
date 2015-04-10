class CollaboratorPolicy < ApplicationPolicy
  attr_reader :wiki

  def initialize(user, record, wiki)
    @wiki = wiki
    super(user,record)
  end

  def create?
    (user.premium? || user.admin?) && user == wiki.user
  end

  def destroy?
    create?
  end
end
