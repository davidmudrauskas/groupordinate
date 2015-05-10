class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :shifts
  validates :name, presence: true
  validates :group_type, presence: true
end
