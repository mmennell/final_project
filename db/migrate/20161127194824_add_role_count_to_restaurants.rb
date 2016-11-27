class AddRoleCountToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :roles_count, :integer
  end
end
