class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :destroy, Comment, user_id: user.id
      can :destroy, Post, author_id: user.id
    end
  end
end
