class ChangeApprovedDefaultValueInJobs < ActiveRecord::Migration[5.0]
  def change
    change_column_default :jobs, :approved, '0'
  end
end
