require 'test_helper'

class ShiftsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @registered_user_group = groups(:registered_user_group)
    @registered_user_shift = shifts(:registered_user_shift)

    @app_admin_group = groups(:app_admin_group)
    @app_admin_shift = shifts(:app_admin_shift)
  end

  # Total outsider
  test "outsider should not get index" do
    get :index, group_id: @registered_user_group
    assert_redirected_to new_user_session_path
  end

  test "outsider should not get new" do
    get :new, group_id: @registered_user_group
    assert_redirected_to new_user_session_path
  end

  test "outsider should not create shift" do
    assert_no_difference('Shift.count') do
      post :create, shift: { start_at: Time.now, user_id: @registered_user }, group_id: @registered_user_group
    end

    assert_redirected_to new_user_session_path
  end

  test "outsider should not show shift" do
    get :show, id: @registered_user_shift
    assert_redirected_to new_user_session_path
  end

  test "outsider should not get edit" do
    get :edit, id: @registered_user_shift
    assert_redirected_to new_user_session_path
  end

  test "outsider should not update shift" do
    patch :update, id: @registered_user_shift, shift: { end_at: Time.now }
    assert_redirected_to new_user_session_path
  end

  test "outsider should not destroy shift" do
    assert_no_difference('Shift.count') do
      delete :destroy, id: @registered_user_shift
    end

    assert_redirected_to new_user_session_path
  end

  # Registered user
  test "registered user should get index" do
    sign_in @registered_user
    get :index, group_id: @registered_user_group
    assert_response :success
    assert_not_nil assigns(:shifts)
  end

  test "registered user should get new" do
    sign_in @registered_user
    get :new, group_id: @registered_user_group
    assert_response :success
  end

  test "registered user should create own shift" do
    sign_in @registered_user
    assert_difference('Shift.count', +1) do
      post :create, shift: { start_at: Time.now, user_id: @registered_user }, group_id: @registered_user_group
    end

    assert_redirected_to group_shifts_path
  end

  test "registered user should create only own shift" do
    sign_in @registered_user
    post :create, shift: { start_at: Time.now, user_id: @app_admin }, group_id: @app_admin_group

    assert(@app_admin.shifts.count == 1)
    assert(@registered_user.shifts.count == 2)
    assert_redirected_to group_shifts_path
  end  

  test "registered user should show own shift" do
    sign_in @registered_user
    get :show, id: @registered_user_shift, group_id: @registered_user_group
    assert_response :success
  end

  test "registered user should show other user shift" do
    sign_in @registered_user
    get :show, id: @app_admin_shift, group_id: @app_admin_group
    assert_response :success
  end

  test "registered user should get own edit" do
    sign_in @registered_user
    get :edit, id: @registered_user_shift, group_id: @registered_user_group
    assert_response :success
  end

  test "registered user should not get other user edit" do
    sign_in @registered_user
    get :edit, id: @app_admin_shift, group_id: @app_admin_group
    assert_redirected_to root_path
  end

  test "registered user should update own shift" do
    sign_in @registered_user
    patch :update, id: @registered_user_shift, shift: { end_at: Time.now }, group_id: @registered_user_group
    assert_redirected_to shift_path(assigns(:shift))
  end

  test "registered user should not update other user shift" do
    sign_in @registered_user
    patch :update, id: @app_admin_shift, shift: { end_at: Time.now }, group_id: @app_admin_group
    assert_redirected_to root_path
  end

  test "registered user should destroy own shift" do
    sign_in @registered_user
    assert_difference('Shift.count', -1) do
      delete :destroy, id: @registered_user_shift, group_id: @registered_user_group
    end

    assert_redirected_to group_shifts_path
  end

  test "registered user not should destroy other user shift" do
    sign_in @registered_user
    assert_no_difference('Shift.count') do
      delete :destroy, id: @app_admin_shift, group_id: @registered_user_group
    end

    assert_redirected_to root_path
  end

  # App admin
  test "app admin should get index" do
    sign_in @app_admin
    get :index, group_id: @app_admin_group
    assert_response :success
    assert_not_nil assigns(:shifts)
  end

  test "app admin should get new" do
    sign_in @app_admin
    get :new, group_id: @app_admin_group
    assert_response :success
  end

  test "app admin should create own shift" do
    sign_in @app_admin
    assert_difference('Shift.count', +1) do
      post :create, shift: { start_at: Time.now, user_id: @app_admin }, group_id: @app_admin_group
    end

    assert_redirected_to group_shifts_path
  end

  test "app admin should create only own shift" do
    sign_in @app_admin
    post :create, shift: { start_at: Time.now, user_id: @registered_user }, group_id: @registered_user_group

    assert(@registered_user.shifts.count == 1)
    assert(@app_admin.shifts.count == 2)
    assert_redirected_to group_shifts_path
  end  

  test "app admin should show own shift" do
    sign_in @app_admin
    get :show, id: @app_admin_shift, group_id: @app_admin_group
    assert_response :success
  end

  test "app admin should show other user shift" do
    sign_in @app_admin
    get :show, id: @registered_user_shift, group_id: @registered_user_group
    assert_response :success
  end

  test "app admin should get own edit" do
    sign_in @app_admin
    get :edit, id: @app_admin_shift, group_id: @app_admin_group
    assert_response :success
  end

  test "app admin should get other user edit" do
    sign_in @app_admin
    get :edit, id: @registered_user_shift, group_id: @registered_user_group
    assert_response :success
  end

  test "app admin should update own shift" do
    sign_in @app_admin
    patch :update, id: @app_admin_shift, shift: { end_at: Time.now }, group_id: @app_admin_group
    assert_redirected_to shift_path(assigns(:shift))
  end

  test "app admin should update other user shift" do
    sign_in @app_admin
    patch :update, id: @registered_user_shift, shift: { end_at: Time.now }, group_id: @registered_user_group
    assert_redirected_to shift_path(assigns(:shift))
  end

  test "app admin should destroy own shift" do
    sign_in @app_admin
    assert_difference('Shift.count', -1) do
      delete :destroy, id: @app_admin_shift, group_id: @app_admin_group
    end

    assert_redirected_to group_shifts_path
  end

  test "app admin should destroy other user shift" do
    sign_in @app_admin
    assert_difference('Shift.count', -1) do
      delete :destroy, id: @registered_user_shift, group_id: @registered_user_group
    end

    assert_redirected_to group_shifts_path
  end
end
