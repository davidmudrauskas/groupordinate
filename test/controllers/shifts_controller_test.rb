require 'test_helper'

class ShiftsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @shift = shifts(:one)
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

  test "outsider should not create shift" do
    assert_no_difference('Shift.count') do
      post :create, shift: {  }
    end

    assert_redirected_to new_user_session_path
  end

  test "outsider should not show shift" do
    get :show, id: @shift
    assert_redirected_to new_user_session_path
  end

  test "outsider should not get edit" do
    get :edit, id: @shift
    assert_redirected_to new_user_session_path
  end

  test "outsider should not update shift" do
    patch :update, id: @shift, shift: {  }
    assert_redirected_to new_user_session_path
  end

  test "outsider should not destroy shift" do
    assert_no_difference('Shift.count', -1) do
      delete :destroy, id: @shift
    end

    assert_redirected_to new_user_session_path
  end

  # Registered user
  test "registered user should get index" do
    sign_in @registered_user
    get :index
    assert_response :success
    assert_not_nil assigns(:shifts)
  end

  test "registered user should get new" do
    sign_in @registered_user
    get :new
    assert_response :success
  end

  test "registered user should create shift" do
    sign_in @registered_user
    assert_difference('Shift.count', +1) do
      post :create, shift: { start_at: Time.now, user_id: @registered_user.id }
    end

    assert_redirected_to shift_path(assigns(:shift))
  end

  test "registered user should show shift" do
    sign_in @registered_user
    get :show, id: @shift
    assert_response :success
  end

  test "registered user should get edit" do
    sign_in @registered_user
    get :edit, id: @shift
    assert_response :success
  end

  test "registered user should update shift" do
    sign_in @registered_user
    patch :update, id: @shift, shift: { end_at: Time.now }
    assert_redirected_to shift_path(assigns(:shift))
  end

  test "registered user should destroy shift" do
    sign_in @registered_user
    assert_difference('Shift.count', -1) do
      delete :destroy, id: @shift
    end

    assert_redirected_to shifts_path
  end
end
