class Shift < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :start_at, presence: true 
end
