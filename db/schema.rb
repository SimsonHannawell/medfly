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

ActiveRecord::Schema[7.1].define(version: 2025_05_29_143937) do
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

  create_table "basket_items", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "basket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1, null: false
    t.index ["basket_id"], name: "index_basket_items_on_basket_id"
    t.index ["product_id"], name: "index_basket_items_on_product_id"
  end

  create_table "baskets", force: :cascade do |t|
    t.bigint "pharmacy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pharmacy_id"], name: "index_baskets_on_pharmacy_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "pharmacy_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pharmacy_id"], name: "index_favourites_on_pharmacy_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.text "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "delivered?", default: false
    t.bigint "basket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["basket_id"], name: "index_orders_on_basket_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "card_number"
    t.integer "expiry_date"
    t.integer "CVC"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pharmacies", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_pharmacies_on_user_id"
  end

  create_table "pharmacy_products", force: :cascade do |t|
    t.bigint "pharmacy_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pharmacy_id"], name: "index_pharmacy_products_on_pharmacy_id"
    t.index ["product_id"], name: "index_pharmacy_products_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "pharmacy_id", null: false
    t.integer "rating"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pharmacy_id"], name: "index_reviews_on_pharmacy_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "address"
    t.bigint "payment_id"
    t.boolean "pharmacist?", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["payment_id"], name: "index_users_on_payment_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "basket_items", "baskets"
  add_foreign_key "basket_items", "products"
  add_foreign_key "baskets", "pharmacies"
  add_foreign_key "favourites", "pharmacies"
  add_foreign_key "favourites", "users"
  add_foreign_key "orders", "baskets"
  add_foreign_key "orders", "users"
  add_foreign_key "pharmacies", "users"
  add_foreign_key "pharmacy_products", "pharmacies"
  add_foreign_key "pharmacy_products", "products"
  add_foreign_key "reviews", "pharmacies"
  add_foreign_key "reviews", "users"
  add_foreign_key "users", "payments"
end
