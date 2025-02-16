class CreateServiceTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :service_templates do |t|
      t.string :name
      t.text :description
      t.jsonb :pricing_schema
      t.jsonb :service_area_schema
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
