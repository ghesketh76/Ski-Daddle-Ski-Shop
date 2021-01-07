class CreateServicesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :service_name
      t.integer :service_time
      t.integer :cost
    end
  end
end
