class CreateRunsGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :runs do |t|
      t.integer :user_id
      t.string :start_location
      t.string :end_location
      t.string :total_time
      t.decimal :total_distance
      t.string :travel_method
      t.integer :goal_id

      t.timestamps
    end

    create_table :races do |t|
      t.integer :user_id
      t.integer :goal_id
      t.decimal :progress
      t.string :name

      t.timestamps
    end

    create_table :goals do |t|
      t.string :start_location
      t.string :end_location
      t.decimal :total_distance
      t.string :name

      t.timestamps
    end
  end
end
