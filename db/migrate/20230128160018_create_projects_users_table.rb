# frozen_string_literal: true

class CreateProjectsUsersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :projects_users, id: false do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
    end

    add_index :projects_users, %i[project_id user_id], unique: true
  end
end
