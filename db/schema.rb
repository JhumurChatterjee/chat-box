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

ActiveRecord::Schema.define(version: 20_200_828_151_135) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'messages', force: :cascade do |t|
    t.bigint 'receiver_id', null: false
    t.bigint 'sender_id', null: false
    t.string 'content', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['receiver_id'], name: 'index_messages_on_receiver_id'
    t.index ['sender_id'], name: 'index_messages_on_sender_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email'
  end

  add_foreign_key 'messages', 'users', column: 'receiver_id'
  add_foreign_key 'messages', 'users', column: 'sender_id'
end
