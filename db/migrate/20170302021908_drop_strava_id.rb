class DropStravaId < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :strava_id, :integer, default: 0
  end
end
