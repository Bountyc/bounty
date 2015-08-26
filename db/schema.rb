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

ActiveRecord::Schema.define(version: 20150825190855) do

  create_table "answers", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "denial_reason"
  end

  create_table "bounties", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "views"
    t.float    "price"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "poster_id"
    t.integer  "status",      default: 0
  end

  create_table "bounties_tags", id: false, force: :cascade do |t|
    t.integer "bounty_id"
    t.integer "tag_id"
  end

  add_index "bounties_tags", ["bounty_id", "tag_id"], name: "index_bounties_tags_on_bounty_id_and_tag_id"

  create_table "bounty_hunters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bounty_id"
    t.integer  "status",             default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "answer_id"
    t.datetime "started_working_at"
  end

  add_index "bounty_hunters", ["answer_id"], name: "index_bounty_hunters_on_answer_id"
  add_index "bounty_hunters", ["user_id", "bounty_id"], name: "index_bounty_hunters_on_user_id_and_bounty_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "bounty_hunter_id"
    t.integer  "user_id"
    t.integer  "notification_type"
    t.string   "message"
    t.boolean  "seen",              default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "action_link"
    t.boolean  "clicked",           default: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "payer_id"
    t.string   "payment_id"
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.float    "balance",                default: 0.0
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "reputation",             default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "views", force: :cascade do |t|
    t.integer  "bounty_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "withdrawals", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "payout_batch_id"
  end

end
