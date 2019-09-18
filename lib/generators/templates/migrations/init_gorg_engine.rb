class InitGorgEngine < ActiveRecord::Migration[4.2]
  def change


    # You HAVE TO edit this file to avoid conflict with your current migrations
    # For each table and for each column : check if exist in your current project, and comment the line if needed.
    # When it's done, comment the line bellow

    raise Exception.new("You have to check your migration. Edit GorgEngine's generated migration.")

    create_table "configurables", force: :cascade do |t|
      t.string   "name"
      t.string   "value"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "configurables", ["name"], name: "index_configurables_on_name"

    create_table "roles", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "users", force: :cascade do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
      t.string   "firstname"
      t.string   "lastname"
      t.boolean  "is_gadz"
      t.string   "uuid"
      t.datetime "last_gram_sync_at"
      t.string   "hruid",                  default: "", null: false
      t.integer  "role_id"
      t.string   "avatar_url"
    end

    add_index "users", ["email"], name: "index_users_on_email", unique: true
    add_index "users", ["hruid"], name: "index_users_on_hruid", unique: true
    add_index "users", ["is_gadz"], name: "index_users_on_is_gadz"
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    add_index "users", ["role_id"], name: "index_users_on_role_id"
    add_index "users", ["uuid"], name: "index_users_on_uuid", unique: true

  end

end
