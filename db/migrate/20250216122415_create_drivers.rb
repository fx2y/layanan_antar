class CreateDrivers < ActiveRecord::Migration[8.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :drivers, :email, unique: true
    add_index :drivers, :phone, unique: true
  end
end 