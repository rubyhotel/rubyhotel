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

ActiveRecord::Schema.define(version: 20180315235040) do

  create_table "bookings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "cost"
    t.datetime "inDate"
    t.datetime "outDate"
    t.integer "numOfGuests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "phoneNum"
    t.string "position"
    t.integer "hourlyRate"
    t.datetime "startDate"
    t.bigint "Location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Location_id"], name: "index_employees_on_Location_id"
  end

  create_table "facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "type"
    t.integer "price"
    t.bigint "Location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Location_id"], name: "index_facilities_on_Location_id"
  end

  create_table "guests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "phoneNum"
    t.string "creditCardNum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "address"
    t.string "phoneNum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reserves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "Booking_id"
    t.bigint "Location_id"
    t.bigint "Room_id"
    t.bigint "Guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Booking_id"], name: "index_reserves_on_Booking_id"
    t.index ["Guest_id"], name: "index_reserves_on_Guest_id"
    t.index ["Location_id"], name: "index_reserves_on_Location_id"
    t.index ["Room_id"], name: "index_reserves_on_Room_id"
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "roomNum"
    t.string "amenities"
    t.boolean "isVacant"
    t.boolean "isClean"
    t.bigint "Location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Location_id"], name: "index_rooms_on_Location_id"
  end

  add_foreign_key "employees", "Locations"
  add_foreign_key "facilities", "Locations"
  add_foreign_key "reserves", "Bookings"
  add_foreign_key "reserves", "Guests"
  add_foreign_key "reserves", "Locations"
  add_foreign_key "reserves", "Rooms"
  add_foreign_key "rooms", "Locations"
end
