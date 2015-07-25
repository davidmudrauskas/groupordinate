class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_groups

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def set_group
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def set_groups
    @groups = current_user.groups if current_user
  end
end
