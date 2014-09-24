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

ActiveRecord::Schema.define(version: 20140919200607) do

  create_table "detours", force: true do |t|
    t.string   "gender"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "telpriv"
    t.string   "telprivTime"
    t.string   "telbus"
    t.string   "telbusTime"
    t.string   "fax"
    t.string   "email"
    t.string   "schoolname"
    t.string   "schooltype"
    t.string   "zip"
    t.string   "city"
    t.string   "street"
    t.string   "country"
    t.date     "date1"
    t.time     "from1"
    t.time     "to1"
    t.date     "date2"
    t.time     "from2"
    t.time     "to2"
    t.date     "date3"
    t.time     "from3"
    t.time     "to3"
    t.string   "language"
    t.integer  "participnumber"
    t.integer  "groupnumber",                               default: 1
    t.integer  "male"
    t.integer  "female"
    t.string   "age"
    t.string   "schoolgrade"
    t.integer  "teamleader"
    t.string   "havebeen"
    t.text     "reason"
    t.text     "topic"
    t.text     "municstay"
    t.string   "film"
    t.text     "wish"
    t.text     "remarc"
    t.date     "thedate"
    t.string   "day"
    t.time     "thefrom"
    t.time     "theto"
    t.string   "status",                                    default: "offen"
    t.text     "comments"
    t.string   "paid",                                      default: "nein"
    t.string   "bill_sent",                                 default: "nein"
    t.string   "denial_sent",                               default: "nein"
    t.string   "formular",                                  default: "ger"
    t.string   "last_change"
    t.string   "hl_number"
    t.string   "zus_form",                                  default: "nein"
    t.string   "zus_voll",                                  default: "nein"
    t.date     "zf_date"
    t.date     "zv_date"
    t.date     "denial_date"
    t.integer  "vers",                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mahnung",                                   default: 0
    t.date     "mahnungdate"
    t.string   "invoice",                                   default: "ja"
    t.string   "storno_send",                               default: "nein"
    t.date     "storno_date"
    t.string   "invoice_number"
    t.decimal  "given_price",       precision: 8, scale: 2
    t.decimal  "paid_price",        precision: 8, scale: 2, default: 0.0
    t.boolean  "themetour",                                 default: false
    t.boolean  "result_sent",                               default: true
    t.string   "theme_type"
    t.string   "set_paid_external"
    t.datetime "set_paid_date"
  end

  create_table "htseminars", force: true do |t|
    t.string   "gender"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "telpriv"
    t.string   "telprivTime"
    t.string   "telbus"
    t.string   "telbusTime"
    t.string   "fax"
    t.string   "email"
    t.string   "schoolname"
    t.string   "schooltype"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "street"
    t.date     "date1"
    t.time     "from1"
    t.time     "to1"
    t.date     "date2"
    t.time     "from2"
    t.time     "to2"
    t.date     "date3"
    t.time     "from3"
    t.time     "to3"
    t.string   "language"
    t.integer  "participnumber"
    t.integer  "groupnumber",                               default: 1
    t.integer  "male"
    t.integer  "female"
    t.string   "age"
    t.string   "schoolgrade"
    t.integer  "teamleader"
    t.string   "havebeen"
    t.text     "reason"
    t.text     "topic"
    t.text     "municstay"
    t.string   "food"
    t.integer  "foodnumber"
    t.text     "remarc"
    t.date     "thedate"
    t.string   "day"
    t.time     "thefrom"
    t.time     "theto"
    t.string   "status",                                    default: "offen"
    t.text     "comments"
    t.string   "paid",                                      default: "nein"
    t.string   "bill_sent",                                 default: "nein"
    t.string   "denial_sent",                               default: "nein"
    t.string   "last_change"
    t.string   "hl_number"
    t.string   "zus_form",                                  default: "nein"
    t.string   "zus_voll",                                  default: "nein"
    t.date     "zf_date"
    t.date     "zv_date"
    t.date     "denial_date"
    t.integer  "vers",                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mahnung",                                   default: 0
    t.date     "mahnungdate"
    t.string   "invoice",                                   default: "ja"
    t.string   "storno_send",                               default: "nein"
    t.date     "storno_date"
    t.string   "formular"
    t.string   "invoice_number"
    t.decimal  "given_price",       precision: 8, scale: 2
    t.decimal  "paid_price",        precision: 8, scale: 2, default: 0.0
    t.boolean  "result_sent",                               default: true
    t.string   "set_paid_external"
    t.datetime "set_paid_date"
  end

  create_table "htsreferents", force: true do |t|
    t.integer  "htseminar_id"
    t.integer  "referent_id"
    t.integer  "mailsend",     default: 0
    t.date     "maildate"
    t.string   "paid",         default: "nein"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "changed_by"
    t.datetime "changed_on"
  end

  create_table "languages", force: true do |t|
    t.string "language"
  end

  create_table "languages_users", id: false, force: true do |t|
    t.integer "language_id"
    t.integer "user_id"
  end

  create_table "licenses", force: true do |t|
    t.text   "title"
    t.string "shortcut"
  end

  create_table "licenses_users", id: false, force: true do |t|
    t.integer "license_id"
    t.integer "user_id"
  end

  create_table "opentourrefs", force: true do |t|
    t.integer  "opentour_id"
    t.integer  "referent_id"
    t.integer  "mailsend",    default: 0
    t.date     "maildate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paid",        default: "nein"
    t.string   "changed_by"
    t.datetime "changed_on"
  end

  create_table "opentours", force: true do |t|
    t.date     "date"
    t.time     "time"
    t.text     "comment"
    t.string   "language"
    t.string   "status",         default: "activ"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participnumber", default: 0
    t.string   "opentype",       default: ""
  end

  create_table "opentourwishes", force: true do |t|
    t.integer  "opentour_id"
    t.integer  "referent_id"
    t.integer  "mailsend",    default: 0
    t.date     "maildate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referents", force: true do |t|
    t.string   "gender"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "tel"
    t.string   "email"
    t.string   "language1"
    t.string   "language2"
    t.string   "language3"
    t.text     "remarc"
    t.integer  "vers",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tel2"
    t.string   "aktiv",         default: "aktiv"
    t.string   "zip",           default: ""
    t.string   "city",          default: ""
    t.string   "street",        default: ""
    t.string   "country",       default: ""
    t.string   "bank"
    t.string   "blz"
    t.string   "konto"
    t.boolean  "lizenz_hts",    default: false
    t.boolean  "lizenz_ts_all", default: false
    t.boolean  "lizenz_ts_men", default: false
    t.boolean  "lizenz_ts_er",  default: false
    t.boolean  "honorar",       default: true
  end

  create_table "roles", force: true do |t|
    t.string "title"
  end

  create_table "roles_users", force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "themen_topics", force: true do |t|
    t.string "content_type"
    t.text   "content"
    t.string "venue"
  end

  create_table "tourreferents", force: true do |t|
    t.integer  "detour_id"
    t.integer  "referent_id"
    t.integer  "mailsend",    default: 0
    t.date     "maildate"
    t.string   "paid",        default: "nein"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "changed_by"
    t.datetime "changed_on"
  end

  create_table "ts_requests", force: true do |t|
    t.string   "gender"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "telpriv"
    t.string   "telprivTime"
    t.string   "telbus"
    t.string   "telbusTime"
    t.string   "fax"
    t.string   "email"
    t.string   "schoolname"
    t.string   "schooltype"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "street"
    t.date     "date1"
    t.time     "from1"
    t.time     "to1"
    t.date     "date2"
    t.time     "from2"
    t.time     "to2"
    t.date     "date3"
    t.time     "from3"
    t.time     "to3"
    t.string   "language"
    t.integer  "participnumber"
    t.integer  "groupnumber",                               default: 1
    t.integer  "male"
    t.integer  "female"
    t.string   "age"
    t.string   "schoolgrade"
    t.integer  "teamleader"
    t.string   "havebeen"
    t.text     "reason"
    t.text     "topic"
    t.text     "municstay"
    t.string   "food"
    t.integer  "foodnumber"
    t.text     "remarc"
    t.date     "thedate"
    t.string   "day"
    t.time     "thefrom"
    t.time     "theto"
    t.string   "status",                                    default: "offen"
    t.text     "comments"
    t.string   "paid",                                      default: "nein"
    t.string   "bill_sent",                                 default: "nein"
    t.string   "denial_sent",                               default: "nein"
    t.string   "last_change"
    t.string   "hl_number"
    t.string   "zus_form",                                  default: "nein"
    t.string   "zus_voll",                                  default: "nein"
    t.date     "zf_date"
    t.date     "zv_date"
    t.date     "denial_date"
    t.integer  "vers",                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mahnung",                                   default: 0
    t.date     "mahnungdate"
    t.string   "invoice",                                   default: "ja"
    t.string   "storno_sent",                               default: "nein"
    t.date     "storno_date"
    t.string   "invoice_number"
    t.decimal  "given_price",       precision: 8, scale: 2
    t.decimal  "paid_price",        precision: 8, scale: 2, default: 0.0
    t.boolean  "result_sent",                               default: true
    t.string   "set_paid_external"
    t.datetime "set_paid_date"
  end

  create_table "ts_topics", force: true do |t|
    t.string "text"
    t.string "language"
  end

  create_table "tsreferents", force: true do |t|
    t.integer  "ts_request_id"
    t.integer  "referent_id"
    t.integer  "mailsend",      default: 0
    t.date     "maildate"
    t.string   "paid",          default: "nein"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "changed_by"
    t.datetime "changed_on"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "role"
    t.string   "old_login"
    t.string   "crypted_password",          limit: 128, default: "",   null: false
    t.string   "password_confirmation"
    t.string   "salt",                      limit: 128, default: "",   null: false
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "email"
    t.integer  "referent_id"
    t.integer  "gender"
    t.string   "tel"
    t.string   "tel2"
    t.text     "remarc"
    t.integer  "activ",                                 default: 0
    t.string   "zip"
    t.string   "city"
    t.string   "street"
    t.string   "country"
    t.string   "bank"
    t.string   "blz"
    t.string   "konto"
    t.boolean  "honorar",                               default: true
  end

  create_table "workreferents", force: true do |t|
    t.integer  "workshop_id"
    t.integer  "referent_id"
    t.integer  "mailsend",    default: 0
    t.date     "maildate"
    t.string   "paid",        default: "nein"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "changed_by"
    t.datetime "changed_on"
  end

  create_table "workshops", force: true do |t|
    t.string   "gender"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "telpriv"
    t.string   "telprivTime"
    t.string   "telbus"
    t.string   "telbusTime"
    t.string   "fax"
    t.string   "email"
    t.string   "schoolname"
    t.string   "schooltype"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "street"
    t.date     "date1"
    t.time     "from1"
    t.time     "to1"
    t.integer  "participnumber"
    t.integer  "male"
    t.integer  "female"
    t.string   "age"
    t.string   "schoolgrade"
    t.integer  "teamleader"
    t.string   "havebeen"
    t.text     "reason"
    t.text     "municstay"
    t.string   "food"
    t.integer  "foodnumber"
    t.text     "remarc"
    t.date     "thedate"
    t.string   "day"
    t.time     "thefrom"
    t.time     "theto"
    t.string   "status",                                    default: "offen"
    t.string   "referent",                                  default: ""
    t.text     "comments"
    t.string   "paid",                                      default: "nein"
    t.string   "bill_sent",                                 default: "nein"
    t.string   "denial_sent",                               default: "nein"
    t.string   "room"
    t.string   "last_change"
    t.string   "hl_number"
    t.string   "zus_form",                                  default: "nein"
    t.string   "zus_voll",                                  default: "nein"
    t.date     "zf_date"
    t.date     "zv_date"
    t.date     "denial_date"
    t.integer  "vers",                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mahnung",                                   default: 0
    t.date     "mahnungdate"
    t.date     "date2"
    t.time     "from2"
    t.time     "to2"
    t.string   "invoice",                                   default: "ja"
    t.string   "storno_sent",                               default: "nein"
    t.date     "storno_date"
    t.string   "invoice_number"
    t.decimal  "given_price",       precision: 8, scale: 2
    t.decimal  "paid_price",        precision: 8, scale: 2, default: 0.0
    t.boolean  "result_sent",                               default: true
    t.string   "set_paid_external"
    t.datetime "set_paid_date"
  end

end
