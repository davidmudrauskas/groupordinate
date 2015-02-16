require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  # Total outsider
  test "outsider not should get index" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "outsider should not show user" do
    get :show, id: @registered_user
    assert_redirected_to new_user_session_path
  end

  test "outsider should not get edit" do
    get :edit, id: @registered_user
    assert_redirected_to new_user_session_path
  end

  test "outsider should not update user" do
    patch :update, id: @registered_user, user: {  }
    assert_redirected_to new_user_session_path
  end

  test "outsider should not destroy user" do
    assert_no_difference('User.count', -1) do
      delete :destroy, id: @registered_user
    end

    assert_redirected_to new_user_session_path
  end

  # Registered user
  test "registered should get index" do
    sign_in @registered_user
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "registered user should show self" do
    sign_in @registered_user
    get :show, id: @registered_user
    assert_response :success
  end

  test "registered user should get own edit" do
    sign_in @registered_user
    get :edit, id: @registered_user
    assert_response :success
  end

  test "registered user should update self" do
    sign_in @registered_user
    patch :update, id: @registered_user, user: {  }
    assert_redirected_to user_path(assigns(:user))
  end

  test "registered user should destroy self" do
    sign_in @registered_user
    assert_difference('User.count', -1) do
      delete :destroy, id: @registered_user
    end

    assert_redirected_to users_path
  end
end
