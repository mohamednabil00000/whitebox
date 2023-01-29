# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_128_160_018) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'projects', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'leader_id', null: false
    t.integer 'created_by_id', null: false
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_projects_on_name', unique: true
  end

  create_table 'projects_users', id: false, force: :cascade do |t|
    t.bigint 'project_id'
    t.bigint 'user_id'
    t.index %w[project_id user_id], name: 'index_projects_users_on_project_id_and_user_id', unique: true
    t.index ['project_id'], name: 'index_projects_users_on_project_id'
    t.index ['user_id'], name: 'index_projects_users_on_user_id'
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'title', null: false
    t.integer 'assignee_id'
    t.text 'description'
    t.integer 'estimated_points'
    t.integer 'created_by_id', null: false
    t.bigint 'project_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['project_id'], name: 'index_tasks_on_project_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'projects', 'users', column: 'created_by_id'
  add_foreign_key 'projects', 'users', column: 'leader_id'
  add_foreign_key 'tasks', 'projects'
  add_foreign_key 'tasks', 'users', column: 'assignee_id'
  add_foreign_key 'tasks', 'users', column: 'created_by_id'
end
