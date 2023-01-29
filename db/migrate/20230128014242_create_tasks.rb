# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, force: :cascade do |t|
      t.string :title, null: false
      t.integer :assignee_id
      t.text :description
      t.integer :estimated_points
      t.integer :created_by_id, null: false
      t.references :project, index: true, foreign_key: true

      t.timestamps
    end

    add_foreign_key :tasks, :users, column: :assignee_id
    add_foreign_key :tasks, :users, column: :created_by_id, index: false
  end
end
