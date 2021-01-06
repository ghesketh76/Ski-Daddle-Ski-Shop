class CreateCustomersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.integer :age 
      t.string :email
      t.string :password 
    end
  end
end
