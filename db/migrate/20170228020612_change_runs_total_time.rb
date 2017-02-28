class ChangeRunsTotalTime < ActiveRecord::Migration[5.0]
  def change
    remove_column :runs, :total_time
    add_column :runs, :total_time, :integer, default: 0

  end
end
