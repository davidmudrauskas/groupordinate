class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :group_type
      t.timestamps null: false
    end

    create_table :groups_users do |t|
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
