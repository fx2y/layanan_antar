class CreateMitraAdminAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :mitra_admin_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :mitra, null: false, foreign_key: true

      t.timestamps
    end

    add_index :mitra_admin_assignments, [ :user_id, :mitra_id ], unique: true
  end
end
