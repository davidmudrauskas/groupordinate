class Shift < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :start_at, presence: true
  # TODO: validates :end_at, presence: true, date: { after_or_equal_to: :start_at }

  def self.fullcalendar_format(shifts)
    new_format = []
    shifts.each do |shift|
      new_shift = { id: shift.id, title: "Title", start: shift.start_at, end: shift.end_at }
      new_format << new_shift
    end
    new_format
  end
end
