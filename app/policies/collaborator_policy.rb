class CollaboratorPolicy < AppliccationPolicy
  def create?
    user.role == 'premium' && wiki.user == user
  end
end
