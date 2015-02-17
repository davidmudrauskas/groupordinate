class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.belongs_to :user, index: true
      t.string :role_type
      t.timestamps null: false
    end
  end
end
