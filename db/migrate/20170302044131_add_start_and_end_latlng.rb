class AddStartAndEndLatlng < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :start_latlng, :float, array:true, default: []
    add_column :goals, :end_latlng, :float, array:true, default: []
  end
end
