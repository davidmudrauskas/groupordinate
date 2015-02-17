class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :shifts
  has_many :roles, dependent: :destroy
  accepts_nested_attributes_for :roles, allow_destroy: true

  def app_admin?
    roles.exists?(role_type: Role::TYPES[:app_admin])
  end
end
