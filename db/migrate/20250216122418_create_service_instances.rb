class CreateServiceInstances < ActiveRecord::Migration[8.0]
  def change
    create_table :service_instances do |t|
      t.string :name
      t.text :description
      t.text :pricing_details
      t.jsonb :service_area
      t.integer :status
      t.references :service_template, null: false, foreign_key: true
      t.references :mitra, null: false, foreign_key: true

      t.timestamps
    end
  end
end
