# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_17_052444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "board_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "board_desc_idx"
  end

  create_table "boards", force: :cascade do |t|
    t.boolean "game_finishd", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_room_id"
    t.boolean "started", default: false
    t.integer "parent_id"
    t.index ["game_room_id"], name: "index_boards_on_game_room_id"
  end

  create_table "cells", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.boolean "free", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "mark", default: 0
    t.integer "place"
    t.index ["game_id"], name: "index_cells_on_game_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "game_rooms", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "player_turn", default: 0
    t.text "players"
    t.text "viewers"
    t.string "slug"
    t.string "room_name"
    t.bigint "user_id"
    t.index ["slug"], name: "index_game_rooms_on_slug", unique: true
    t.index ["user_id"], name: "index_game_rooms_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.integer "game_won"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "place"
    t.integer "status"
    t.index ["board_id"], name: "index_games_on_board_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "game_room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_room_id"], name: "index_messages_on_game_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "wins", default: 0
    t.integer "losses", default: 0
    t.integer "draws", default: 0
    t.string "user_name"
    t.string "type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boards", "game_rooms"
  add_foreign_key "cells", "games"
  add_foreign_key "game_rooms", "users"
  add_foreign_key "games", "boards"
  add_foreign_key "messages", "game_rooms"
  add_foreign_key "messages", "users"
end
