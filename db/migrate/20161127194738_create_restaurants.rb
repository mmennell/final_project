class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :restaurant_name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :description
      t.string :logo_url
      t.string :contact_name
      t.string :contact_telephone
      t.integer :user_id
      t.boolean :verified

      t.timestamps

    end
  end
end
