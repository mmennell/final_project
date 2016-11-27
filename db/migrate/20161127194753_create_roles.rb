class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_name
      t.string :description
      t.integer :restaurant_id

      t.timestamps

    end
  end
end
