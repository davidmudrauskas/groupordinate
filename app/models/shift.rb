class Shift < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  validates :user_id, presence: true
  validates :start_at, presence: true
  validates :group_id, presence: true
  # TODO: validates :end_at, presence: true, date: { after_or_equal_to: :start_at }

  def self.fullcalendar_format(shifts)
    new_format = []
    shifts.each do |shift|
      email = shift.user.email
      new_shift = { id: shift.id, title: email, start: shift.start_at, end: shift.end_at }
      new_format << new_shift
    end
    new_format
  end
end
