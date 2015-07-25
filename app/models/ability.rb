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

      can :manage, Group do |group|
        group.users.include? user
      end

      can :manage, Invitation do |invitation|
        Group.find(invitation.group_id).users.include? user
      end
    end
  end
end
