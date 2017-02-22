class ChangeNumberFormat < ActiveRecord::Migration[5.0]
  def change
    remove_column :goals, :total_distance, :decimal
    add_column :goals, :total_distance, :float, default: 0

    remove_column :races, :progress, :decimal
    add_column :races, :progress, :float, default: 0

    remove_column :runs, :total_distance, :decimal
    add_column :runs, :total_distance, :float, default: 0
  end
end
