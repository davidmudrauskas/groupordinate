class Ability
  include CanCan::Ability

  def initialize(user)
    if user.app_admin?
      can :manage, :all
    else
      can :read, Shift
      can :manage, Shift do |shift|
        shift.user == user
      end

      can :manage, User do |target_user|
        target_user == user
      end
    end
  end
end
