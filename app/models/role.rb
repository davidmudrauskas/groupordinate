class Role < ActiveRecord::Base
  belongs_to :user

  TYPES = { app_admin: "app_admin" }
end
