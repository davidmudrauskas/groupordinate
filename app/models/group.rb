class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :shifts
  has_many :invitations
  validates :name, presence: true
  validates :group_type, presence: true
  accepts_nested_attributes_for :shifts, :invitations
end
