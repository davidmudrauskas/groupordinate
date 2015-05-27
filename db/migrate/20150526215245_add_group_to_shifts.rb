class AddGroupToShifts < ActiveRecord::Migration
  def change
    add_reference :shifts, :group, index: true
    add_foreign_key :shifts, :groups
  end
end
