# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 3) do

  create_table "contents", :force => true do |t|
    t.column "title",         :string
    t.column "body",          :text
    t.column "body_html",     :text
    t.column "metadata",      :text
    t.column "created_by_id", :integer
    t.column "updated_by_id", :integer
    t.column "updated_at",    :datetime
    t.column "created_at",    :datetime
    t.column "type",          :string
  end

  create_table "taggings", :force => true do |t|
    t.column "tag_id",        :integer, :default => 0,  :null => false
    t.column "taggable_id",   :integer, :default => 0,  :null => false
    t.column "taggable_type", :string,  :default => "", :null => false
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], :name => "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", :unique => true

  create_table "tags", :force => true do |t|
    t.column "name", :string, :default => "", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "name",                      :string
  end

end
