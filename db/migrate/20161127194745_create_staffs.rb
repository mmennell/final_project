class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_telephone
      t.string :avatar_url
      t.integer :home_restaurant_id
      t.integer :role_id
      t.integer :user_id
      t.boolean :verified

      t.timestamps

    end
  end
end
