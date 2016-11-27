class AddJobCountToStaffs < ActiveRecord::Migration[5.0]
  def change
    add_column :staffs, :jobs_count, :integer
  end
end
