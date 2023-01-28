class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, force: :cascade  do |t|
      t.string :name, null:false, unique: true
      t.integer :leader_id, null:false
      t.integer :created_by, null:false
      t.text :description

      t.timestamps
    end

    add_foreign_key :projects, :users, column: :created_by, index: false
    add_foreign_key :projects, :users, column: :leader_id
    add_index :projects, :name, unique: true
  end
end
