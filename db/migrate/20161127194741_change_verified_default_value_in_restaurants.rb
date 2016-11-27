class ChangeVerifiedDefaultValueInRestaurants < ActiveRecord::Migration[5.0]
  def change
    change_column_default :restaurants, :verified, '0'
  end
end
