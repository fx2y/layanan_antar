class CreateMitraDrivers < ActiveRecord::Migration[8.0]
  def change
    create_table :mitra_drivers do |t|
      t.references :driver, null: false, foreign_key: true
      t.references :mitra, null: false, foreign_key: true

      t.timestamps
    end
    add_index :mitra_drivers, [ :driver_id, :mitra_id ], unique: true
  end
end
