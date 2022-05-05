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

ActiveRecord::Schema[7.0].define(version: 2022_05_04_011105) do
  create_table "admin_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_name"
    t.string "password_hash"
    t.string "password_solt"
    t.string "session_id"
    t.datetime "expired_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_admin_users_on_session_id", unique: true
    t.index ["user_name"], name: "index_admin_users_on_user_name", unique: true
  end

  create_table "attach_selling_products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "selling_product_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_attach_selling_products_on_product_id"
    t.index ["selling_product_id", "product_id"], name: "attach_selling_products_index", unique: true
    t.index ["selling_product_id"], name: "index_attach_selling_products_on_selling_product_id"
  end

  create_table "cart_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "selling_product_id"
    t.decimal "price_without_tax", precision: 10, scale: 2, null: false
    t.decimal "price_with_tax", precision: 10, scale: 2, null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["selling_product_id"], name: "index_cart_items_on_selling_product_id"
  end

  create_table "carts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shipping_address_id"
    t.bigint "purchase_id"
    t.bigint "payment_method_id"
    t.index ["member_id"], name: "index_carts_on_member_id"
    t.index ["payment_method_id"], name: "index_carts_on_payment_method_id"
    t.index ["purchase_id"], name: "index_carts_on_purchase_id"
    t.index ["shipping_address_id"], name: "index_carts_on_shipping_address_id"
  end

  create_table "members", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "default_payment_method_id"
    t.bigint "default_shipping_address_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_customer_id"
    t.index ["default_payment_method_id"], name: "fk_rails_df9754084a"
    t.index ["default_shipping_address_id"], name: "fk_rails_5185efcc8a"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "payment_methods", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "index", null: false
    t.bigint "member_id", null: false
    t.string "stripe_paymen_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id", "index"], name: "index_payment_methods_on_member_id_and_index", unique: true
    t.index ["member_id"], name: "index_payment_methods_on_member_id"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "purchase_id", null: false
    t.integer "total_price", null: false
    t.bigint "payment_method_id", null: false
    t.string "stripe_payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_method_id"], name: "index_purchase_payments_on_payment_method_id"
    t.index ["purchase_id"], name: "index_purchase_payments_on_purchase_id"
  end

  create_table "purchase_products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "selling_product_id", null: false
    t.bigint "purchase_id"
    t.string "product_name"
    t.decimal "price_with_tax", precision: 10, scale: 2, null: false
    t.decimal "price_without_tax", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_purchase_products_on_purchase_id"
    t.index ["selling_product_id"], name: "index_purchase_products_on_selling_product_id"
  end

  create_table "purchase_shipping_addresses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "purchase_id", null: false
    t.bigint "shipping_address_id", null: false
    t.string "name"
    t.string "prefecture"
    t.string "city"
    t.string "address_line"
    t.string "building_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_purchase_shipping_addresses_on_purchase_id"
    t.index ["shipping_address_id"], name: "index_purchase_shipping_addresses_on_shipping_address_id"
  end

  create_table "purchases", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "code", null: false
    t.datetime "sold_at", null: false
    t.integer "price_with_tax"
    t.integer "price_without_tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_purchases_on_code"
    t.index ["member_id"], name: "index_purchases_on_member_id"
  end

  create_table "selling_product_classes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_selling_product_classes_on_code", unique: true
  end

  create_table "selling_products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "selling_product_class_id", null: false
    t.string "name", null: false
    t.integer "price", null: false
    t.bigint "tax_type_id", null: false
    t.integer "price_type", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_selling_products_on_code", unique: true
    t.index ["selling_product_class_id"], name: "index_selling_products_on_selling_product_class_id"
    t.index ["tax_type_id"], name: "index_selling_products_on_tax_type_id"
  end

  create_table "shipping_addresses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "index", null: false
    t.bigint "member_id", null: false
    t.string "name", null: false
    t.string "postal_code", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "address_line", null: false
    t.string "building_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id", "index"], name: "index_shipping_addresses_on_member_id_and_index", unique: true
    t.index ["member_id"], name: "index_shipping_addresses_on_member_id"
  end

  create_table "stock_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "warehouse_id"
    t.integer "quantity"
    t.integer "allowable_quantity"
    t.integer "process_quantity"
    t.integer "bad_quantity"
    t.integer "hold_quantity"
    t.integer "increase"
    t.integer "allowable_increase"
    t.integer "process_increase"
    t.integer "bad_increase"
    t.integer "hold_increase"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "purchase_product_id"
    t.index ["product_id"], name: "index_stock_records_on_product_id"
    t.index ["purchase_product_id"], name: "index_stock_records_on_purchase_product_id"
    t.index ["warehouse_id"], name: "index_stock_records_on_warehouse_id"
  end

  create_table "stocks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "warehouse_id", null: false
    t.integer "quantity", null: false
    t.integer "allowable_quantity", null: false
    t.integer "process_quantity", null: false
    t.integer "bad_quantity", null: false
    t.integer "hold_quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "warehouse_id"], name: "index_stocks_on_product_id_and_warehouse_id", unique: true
    t.index ["product_id"], name: "index_stocks_on_product_id"
    t.index ["warehouse_id"], name: "index_stocks_on_warehouse_id"
  end

  create_table "tax_rates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "tax_type_id", null: false
    t.date "begin_at", null: false
    t.date "end_at"
    t.decimal "rate", precision: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tax_type_id"], name: "index_tax_rates_on_tax_type_id"
  end

  create_table "tax_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "warehouses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "members", "payment_methods", column: "default_payment_method_id"
  add_foreign_key "members", "shipping_addresses", column: "default_shipping_address_id"
end
