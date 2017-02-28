class ChangeRunLocationsToArray < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :start_latlng, :float, array:true, default: []
    add_column :runs, :end_latlng, :float, array:true, default: []

  end
end
