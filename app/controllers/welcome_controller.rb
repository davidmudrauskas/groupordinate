class WelcomeController < ApplicationController
  def index
    if current_user && current_user.groups.first
      redirect_to group_shifts_path(current_user.groups.first)
    elsif current_user
      redirect_to new_group_path
    end

    # else
    # TODO: invitations_path
  end
end