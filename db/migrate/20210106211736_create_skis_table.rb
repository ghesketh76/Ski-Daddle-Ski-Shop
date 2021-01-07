class CreateSkisTable < ActiveRecord::Migration[6.0]
  def change
    create_table :skis do |t|
      t.string :make 
      t.string :model
      t.string :ski_type
      t.integer :ski_length
      t.string :ski_condition
      t.references :customer
    end
  end
end
