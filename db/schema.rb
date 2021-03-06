# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100810151922) do

  create_table "attachments", :force => true do |t|
    t.integer "position",      :default => 1
    t.integer "image_id"
    t.integer "page_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
  end

  add_index "attachments", ["image_id"], :name => "index_attachments_on_image_id"
  add_index "attachments", ["page_id"], :name => "index_attachments_on_page_id"
  add_index "attachments", ["position"], :name => "index_attachments_on_position"

  create_table "config", :force => true do |t|
    t.string "key",         :limit => 40, :default => "", :null => false
    t.string "value",                     :default => ""
    t.text   "description"
  end

  add_index "config", ["key"], :name => "key", :unique => true

  create_table "extension_meta", :force => true do |t|
    t.string  "name"
    t.integer "schema_version", :default => 0
    t.boolean "enabled",        :default => true
  end

  create_table "forms", :force => true do |t|
    t.string   "title"
    t.string   "action"
    t.string   "redirect_to"
    t.text     "body"
    t.text     "content"
    t.text     "config"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.text     "secondary"
  end

  create_table "image_collection_entries", :force => true do |t|
    t.integer  "image_id"
    t.integer  "image_collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_collection_entries", ["image_collection_id"], :name => "index_image_collection_entries_on_image_collection_id"

  create_table "image_collections", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.string   "caption"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.string   "asset_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "layouts", :force => true do |t|
    t.string   "name",          :limit => 100
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "content_type",  :limit => 40
    t.integer  "lock_version",                 :default => 0
  end

  create_table "page_fields", :force => true do |t|
    t.integer "page_id"
    t.string  "name"
    t.string  "content"
  end

  add_index "page_fields", ["page_id", "name", "content"], :name => "index_page_fields_on_page_id_and_name_and_content"

  create_table "page_parts", :force => true do |t|
    t.string   "name",             :limit => 100
    t.string   "filter_id",        :limit => 25
    t.text     "content"
    t.integer  "page_id"
    t.string   "page_part_type"
    t.string   "string_content"
    t.boolean  "boolean_content"
    t.integer  "integer_content"
    t.datetime "datetime_content"
  end

  add_index "page_parts", ["boolean_content"], :name => "index_page_parts_on_boolean_content"
  add_index "page_parts", ["datetime_content"], :name => "index_page_parts_on_datetime_content"
  add_index "page_parts", ["integer_content"], :name => "index_page_parts_on_integer_content"
  add_index "page_parts", ["page_id", "name"], :name => "parts_by_page"
  add_index "page_parts", ["string_content"], :name => "index_page_parts_on_string_content"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "slug",          :limit => 100
    t.string   "breadcrumb",    :limit => 160
    t.string   "class_name",    :limit => 25
    t.integer  "status_id",                    :default => 1,     :null => false
    t.integer  "parent_id"
    t.integer  "layout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "virtual",                      :default => false, :null => false
    t.integer  "lock_version",                 :default => 0
    t.integer  "position",                     :default => 0
  end

  add_index "pages", ["class_name"], :name => "altered_pages_class_name"
  add_index "pages", ["parent_id"], :name => "altered_pages_parent_id"
  add_index "pages", ["slug", "parent_id"], :name => "altered_pages_child_slug"
  add_index "pages", ["virtual", "status_id"], :name => "altered_pages_published"

  create_table "responses", :force => true do |t|
    t.text     "result_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "snippets", :force => true do |t|
    t.string   "name",          :limit => 100, :default => "", :null => false
    t.string   "filter_id",     :limit => 25
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "lock_version",                 :default => 0
  end

  add_index "snippets", ["name"], :name => "name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name",          :limit => 100
    t.string   "email"
    t.string   "login",         :limit => 40,  :default => "",    :null => false
    t.string   "password",      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "admin",                        :default => false, :null => false
    t.boolean  "designer",                     :default => false, :null => false
    t.text     "notes"
    t.integer  "lock_version",                 :default => 0
    t.string   "salt"
    t.string   "session_token"
    t.string   "locale"
  end

  add_index "users", ["login"], :name => "login", :unique => true

end
