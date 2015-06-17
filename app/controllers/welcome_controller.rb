class WelcomeController < ApplicationController
  def index
    if current_user.groups.first
      redirect_to group_shifts_path(current_user.groups.first)
    end
    # else
    # TODO: invitations_path
  end
end