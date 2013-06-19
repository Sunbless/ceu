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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130619221658) do

  create_table "agents", :force => true do |t|
    t.string   "uid"
    t.string   "agent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cases", :force => true do |t|
    t.integer  "district_id"
    t.integer  "phi_id"
    t.integer  "he_id"
    t.integer  "user_id"
    t.string   "protocol"
    t.text     "dg_syndrom"
    t.date     "date_of_dg"
    t.integer  "labconfirmed"
    t.integer  "laboratory_id"
    t.date     "date_lab"
    t.integer  "agent_id"
    t.date     "date_report"
    t.date     "date_entry"
    t.integer  "vaccin"
    t.integer  "operator_id"
    t.text     "comment"
    t.string   "patient_name"
    t.string   "patient_surname"
    t.integer  "age"
    t.date     "date_of_birth"
    t.date     "date_death"
    t.string   "sex"
    t.string   "jmbg"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "icd_id"
  end

  create_table "centers", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "uid"
    t.integer  "municipality_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "districts", :force => true do |t|
    t.integer  "code"
    t.integer  "code_stat"
    t.string   "abbr"
    t.string   "name_eng"
    t.string   "centar"
    t.string   "name"
    t.integer  "population"
    t.integer  "municipalities"
    t.integer  "entity_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "entities", :force => true do |t|
    t.string   "description"
    t.string   "description_eng"
    t.string   "abbr"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "hes", :force => true do |t|
    t.integer  "center_id"
    t.string   "code"
    t.string   "name"
    t.integer  "chief_id"
    t.integer  "nurse_id"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "icds", :force => true do |t|
    t.string   "code"
    t.string   "disease_bsn"
    t.string   "disease_eng"
    t.integer  "int"
    t.integer  "both"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "laboratories", :force => true do |t|
    t.string   "name"
    t.string   "uid"
    t.integer  "municipality_id"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "municipalities", :force => true do |t|
    t.string   "municipality"
    t.integer  "district_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "phis", :force => true do |t|
    t.string   "abbrev"
    t.string   "address"
    t.string   "full_bsn"
    t.string   "full_eng"
    t.string   "mail_no"
    t.integer  "municipality_id"
    t.string   "phone"
    t.string   "fax"
    t.string   "epidemiologist"
    t.string   "email"
    t.string   "post"
    t.integer  "district_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "name"
    t.string   "surname"
    t.string   "uid"
    t.integer  "user_type"
    t.string   "street"
    t.string   "post"
    t.integer  "municipality_id"
    t.string   "phone"
    t.string   "specialist"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
