class CreateMitras < ActiveRecord::Migration[8.0]
  def change
    create_table :mitras do |t|
      t.string :business_name
      t.text :business_address
      t.string :contact_person_name
      t.string :contact_person_phone
      t.string :email
      t.integer :status

      t.timestamps
    end
    add_index :mitras, :email, unique: true
  end
end
