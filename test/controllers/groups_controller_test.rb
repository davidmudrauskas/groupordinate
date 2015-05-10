require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @registered_user.groups << groups(:registered_user_group)
    @app_admin.groups << groups(:app_admin_group)
    @registered_user_group = @registered_user.groups.first
    @app_admin_group = @app_admin.groups.first
  end

  # Total outsider
  test "outsider should not get index" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "outsider should not get new" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "outsider should not create group" do
    assert_no_difference('Group.count') do
      post :create, group: { name: "New group", group_type: "private" }
    end

    assert_redirected_to new_user_session_path
  end

  test "outsider should not show group" do
    get :show, id: @registered_user_group
    assert_redirected_to new_user_session_path
  end

  test "outsider should not get edit" do
    get :edit, id: @registered_user_group
    assert_redirected_to new_user_session_path
  end

  test "outsider should not update group" do
    patch :update, id: @registered_user_group, group: { name: "Updated group" }
    assert_redirected_to new_user_session_path
  end

  test "outsider should not destroy group" do
    assert_no_difference('Group.count') do
      delete :destroy, id: @registered_user_group
    end

    assert_redirected_to new_user_session_path
  end

  # Registered user
  test "registered user should get index" do
    sign_in @registered_user
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "registered user should get new" do
    sign_in @registered_user
    get :new
    assert_response :success
  end

  test "registered user should create own group" do
    sign_in @registered_user
    assert_difference('Group.count', +1) do
      post :create, group: { name: "New group", group_type: "private" }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "registered user should show own group" do
    sign_in @registered_user
    get :show, id: @registered_user_group
    assert_response :success
  end

  test "registered user should not show other user group" do
    sign_in @registered_user
    get :show, id: @app_admin_group
    assert_redirected_to root_path
  end

  test "registered user should get own edit" do
    sign_in @registered_user
    get :edit, id: @registered_user_group
    assert_response :success
  end

  test "registered user should not get other user edit" do
    sign_in @registered_user
    get :edit, id: @app_admin_group
    assert_redirected_to root_path
  end

  test "registered user should update own group" do
    sign_in @registered_user
    patch :update, id: @registered_user_group, group: { end_at: Time.now }
    assert_redirected_to group_path(assigns(:group))
  end

  test "registered user should not update other user group" do
    sign_in @registered_user
    patch :update, id: @app_admin_group, group: { end_at: Time.now }
    assert_redirected_to root_path
  end

  test "registered user should destroy own group" do
    sign_in @registered_user
    assert_difference('Group.count', -1) do
      delete :destroy, id: @registered_user_group
    end

    assert_redirected_to groups_path
  end

  test "registered user not should destroy other user group" do
    sign_in @registered_user
    assert_no_difference('Group.count') do
      delete :destroy, id: @app_admin_group
    end

    assert_redirected_to root_path
  end

  # App admin
  test "app admin should get index" do
    sign_in @app_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "app admin should get new" do
    sign_in @app_admin
    get :new
    assert_response :success
  end

  test "app admin should create own group" do
    sign_in @app_admin
    assert_difference('Group.count', +1) do
      post :create, group: { name: "New group", group_type: "private" }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "app admin should show own group" do
    sign_in @app_admin
    get :show, id: @app_admin_group
    assert_response :success
  end

  test "app admin should show other user group" do
    sign_in @app_admin
    get :show, id: @registered_user_group
    assert_response :success
  end

  test "app admin should get own edit" do
    sign_in @app_admin
    get :edit, id: @app_admin_group
    assert_response :success
  end

  test "app admin should get other user edit" do
    sign_in @app_admin
    get :edit, id: @registered_user_group
    assert_response :success
  end

  test "app admin should update own group" do
    sign_in @app_admin
    patch :update, id: @app_admin_group, group: { end_at: Time.now }
    assert_redirected_to group_path(assigns(:group))
  end

  test "app admin should update other user group" do
    sign_in @app_admin
    patch :update, id: @registered_user_group, group: { end_at: Time.now }
    assert_redirected_to group_path(assigns(:group))
  end

  test "app admin should destroy own group" do
    sign_in @app_admin
    assert_difference('Group.count', -1) do
      delete :destroy, id: @app_admin_group
    end

    assert_redirected_to groups_path
  end

  test "app admin should destroy other user group" do
    sign_in @app_admin
    assert_difference('Group.count', -1) do
      delete :destroy, id: @registered_user_group
    end

    assert_redirected_to groups_path
  end
end
