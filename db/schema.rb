# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_201_228_084_343) do
  create_table 'boards', force: :cascade do |t|
    t.boolean 'game_finishd', default: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'game_room_id'
    t.index ['game_room_id'], name: 'index_boards_on_game_room_id'
  end

  create_table 'cells', force: :cascade do |t|
    t.integer 'game_id', null: false
    t.boolean 'empty', default: true
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'mark', default: 0
    t.integer 'place'
    t.index ['game_id'], name: 'index_cells_on_game_id'
  end

  create_table 'game_room_users', force: :cascade do |t|
    t.integer 'game_room_id', null: false
    t.integer 'users_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['game_room_id'], name: 'index_game_room_users_on_game_room_id'
    t.index ['users_id'], name: 'index_game_room_users_on_users_id'
  end

  create_table 'game_rooms', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'server'
  end

  create_table 'games', force: :cascade do |t|
    t.integer 'board_id', null: false
    t.boolean 'game_won', default: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'place'
    t.index ['board_id'], name: 'index_games_on_board_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'wins', default: 0
    t.integer 'losses', default: 0
    t.integer 'draws', default: 0
    t.string 'user_name'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'boards', 'game_rooms'
  add_foreign_key 'cells', 'games'
  add_foreign_key 'game_room_users', 'game_rooms'
  add_foreign_key 'game_room_users', 'users', column: 'users_id'
  add_foreign_key 'games', 'boards'
end
