class AddDateToRides < ActiveRecord::Migration[5.1]
  def change
    add_column :rides, :date, :datetime, default: 'CURRENT_TIMESTAMP'
  end
end
