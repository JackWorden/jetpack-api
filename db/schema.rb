# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160421023944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "body",       null: false
    t.integer  "issue_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer "project_id",                   null: false
    t.integer "sprint_id"
    t.integer "story_id"
    t.integer "assignee_id"
    t.text    "description"
    t.integer "points",      default: 1,      null: false
    t.string  "status",      default: "todo"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "team_id"
    t.integer  "active_sprint_id"
  end

  add_index "projects", ["team_id"], name: "index_projects_on_team_id", using: :btree

  create_table "sprints", force: :cascade do |t|
    t.date    "end_date"
    t.integer "project_id", null: false
    t.date    "start_date"
  end

  create_table "stories", force: :cascade do |t|
    t.integer "project_id",  null: false
    t.integer "sprint_id"
    t.string  "title",       null: false
    t.text    "description"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "team_id"
    t.string   "name",                null: false
    t.integer  "github_id",           null: false
    t.string   "token"
    t.string   "github_access_token"
    t.string   "profile_picture_url"
  end

  add_index "users", ["github_access_token"], name: "index_users_on_github_access_token", unique: true, using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree
  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

  add_foreign_key "projects", "teams"
end
