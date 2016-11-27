class AddStaffCountToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :staffs_count, :integer
  end
end
