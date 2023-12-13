class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    if user.admin?
      can :manage, :all
    else
      can %i[destroy create], Comment, author_id: user.id
      can %i[destroy create], Post, author_id: user.id
    end
  end
end
