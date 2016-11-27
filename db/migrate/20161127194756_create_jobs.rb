class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :role_id
      t.float :hourly_rate
      t.integer :staff_id
      t.boolean :approved

      t.timestamps

    end
  end
end
