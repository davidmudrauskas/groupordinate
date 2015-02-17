require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "app_admin?" do
    assert_not(@registered_user.app_admin?)
    assert(@app_admin.app_admin?)
  end
end
