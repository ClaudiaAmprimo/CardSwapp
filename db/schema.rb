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

ActiveRecord::Schema[7.0].define(version: 2023_10_30_141910) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.string "name", null: false
    t.string "set", null: false
    t.string "rarity", null: false
    t.string "type", null: false
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cards_on_name"
  end

  create_table "cards_collections", id: false, force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.bigint "card_id", null: false
    t.index ["card_id", "collection_id"], name: "index_cards_collections_on_card_id_and_collection_id"
    t.index ["collection_id", "card_id"], name: "index_cards_collections_on_collection_id_and_card_id"
  end

  create_table "collections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.bigint "trade_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_requests_on_receiver_id"
    t.index ["sender_id"], name: "index_requests_on_sender_id"
    t.index ["trade_id"], name: "index_requests_on_trade_id"
  end

  create_table "trade_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "trade_id", null: false
    t.bigint "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_trade_items_on_card_id"
    t.index ["trade_id"], name: "index_trade_items_on_trade_id"
    t.index ["user_id"], name: "index_trade_items_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "user_1_id"
    t.bigint "user_2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "initiated", null: false
    t.index ["status"], name: "index_trades_on_status"
    t.index ["user_1_id"], name: "index_trades_on_user_1_id"
    t.index ["user_2_id"], name: "index_trades_on_user_2_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username"
  end

  create_table "wantlist_items", force: :cascade do |t|
    t.bigint "wantlist_id"
    t.bigint "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_wantlist_items_on_card_id"
    t.index ["wantlist_id"], name: "index_wantlist_items_on_wantlist_id"
  end

  create_table "wantlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wantlists_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "collections", "users"
  add_foreign_key "requests", "trades"
  add_foreign_key "requests", "users", column: "receiver_id"
  add_foreign_key "requests", "users", column: "sender_id"
  add_foreign_key "trade_items", "cards"
  add_foreign_key "trade_items", "trades"
  add_foreign_key "trade_items", "users"
  add_foreign_key "trades", "users", column: "user_1_id"
  add_foreign_key "trades", "users", column: "user_2_id"
  add_foreign_key "wantlist_items", "cards"
  add_foreign_key "wantlist_items", "wantlists"
  add_foreign_key "wantlists", "users"
end
