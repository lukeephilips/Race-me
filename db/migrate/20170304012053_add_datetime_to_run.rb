class AddDatetimeToRun < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :date, :datetime
  end
end
