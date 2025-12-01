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

ActiveRecord::Schema[8.1].define(version: 2025_12_01_121500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attachments", force: :cascade do |t|
    t.string "attachment_type"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "layer_order"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "x_position"
    t.integer "y_position"
  end

  create_table "build_attachments", force: :cascade do |t|
    t.bigint "attachment_id", null: false
    t.bigint "build_id", null: false
    t.datetime "created_at", null: false
    t.jsonb "location", default: {}
    t.datetime "updated_at", null: false
    t.integer "x_position"
    t.integer "y_position"
    t.index ["attachment_id"], name: "index_build_attachments_on_attachment_id"
    t.index ["build_id"], name: "index_build_attachments_on_build_id"
  end

  create_table "builds", force: :cascade do |t|
    t.jsonb "attachment_overlays", default: []
    t.datetime "created_at", null: false
    t.bigint "gun_id", null: false
    t.boolean "is_public"
    t.integer "likes_count", default: 0
    t.string "name"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["gun_id"], name: "index_builds_on_gun_id"
    t.index ["user_id"], name: "index_builds_on_user_id"
  end

  create_table "gun_attachments", force: :cascade do |t|
    t.bigint "attachment_id", null: false
    t.string "attachment_type"
    t.datetime "created_at", null: false
    t.bigint "gun_id", null: false
    t.datetime "updated_at", null: false
    t.index ["attachment_id"], name: "index_gun_attachments_on_attachment_id"
    t.index ["gun_id"], name: "index_gun_attachments_on_gun_id"
  end

  create_table "guns", force: :cascade do |t|
    t.text "allowed_attachment_types"
    t.integer "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "jwt_deny_lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "exp"
    t.string "jti"
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_deny_lists_on_jti"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "build_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["build_id"], name: "index_likes_on_build_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "actor_id"
    t.datetime "created_at", null: false
    t.string "message"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.boolean "read", default: false
    t.integer "recipient_id", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_notifications_on_actor_id"
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "build_attachments", "attachments"
  add_foreign_key "build_attachments", "builds"
  add_foreign_key "builds", "guns"
  add_foreign_key "builds", "users"
  add_foreign_key "gun_attachments", "attachments"
  add_foreign_key "gun_attachments", "guns"
  add_foreign_key "likes", "builds"
  add_foreign_key "likes", "users"
end
