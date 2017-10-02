class CreateRides < ActiveRecord::Migration[5.1]
  def change
    create_table :rides do |t|
      t.string :address_start
      t.string :address_end
      t.float :distance
      t.float :price

      t.timestamps
    end
  end
end
