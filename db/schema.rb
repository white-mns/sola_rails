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

ActiveRecord::Schema.define(version: 2019_08_27_081603) do

  create_table "equips", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.integer "artifact_id"
    t.integer "equip_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artifact_id"], name: "index_equips_on_artifact_id"
    t.index ["created_at"], name: "index_equips_on_created_at"
    t.index ["e_no", "created_at"], name: "createdat_and_eno"
    t.index ["equip_num"], name: "index_equips_on_equip_num"
  end

  create_table "names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_no"], name: "index_names_on_e_no"
    t.index ["name"], name: "index_names_on_name"
  end

  create_table "proper_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "proper_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_proper_names_on_name"
    t.index ["proper_id"], name: "index_proper_names_on_proper_id"
  end

  create_table "set_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.integer "class_id"
    t.integer "class_num"
    t.integer "lv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_id"], name: "index_set_classes_on_class_id"
    t.index ["class_num"], name: "index_set_classes_on_class_num"
    t.index ["created_at"], name: "index_set_classes_on_created_at"
    t.index ["e_no", "created_at"], name: "createdat_and_eno"
    t.index ["lv"], name: "index_set_classes_on_lv"
  end

  create_table "skill_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "skill_id"
    t.string "name"
    t.integer "range"
    t.integer "cost_id"
    t.integer "sp"
    t.integer "timing_id"
    t.string "text"
    t.integer "is_artifact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_id"], name: "index_skill_data_on_cost_id"
    t.index ["is_artifact"], name: "index_skill_data_on_is_artifact"
    t.index ["name"], name: "index_skill_data_on_name"
    t.index ["range"], name: "index_skill_data_on_range"
    t.index ["skill_id"], name: "index_skill_data_on_skill_id"
    t.index ["sp"], name: "index_skill_data_on_sp"
    t.index ["timing_id"], name: "index_skill_data_on_timing_id"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.integer "battle_type"
    t.integer "set_no"
    t.integer "skill_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.integer "str"
    t.integer "vit"
    t.integer "sense"
    t.integer "agi"
    t.integer "mag"
    t.integer "int"
    t.integer "will"
    t.integer "charm"
    t.integer "line"
    t.integer "role_id"
    t.integer "used_ap"
    t.integer "used_stp"
    t.integer "goodness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agi"], name: "index_statuses_on_agi"
    t.index ["charm"], name: "index_statuses_on_charm"
    t.index ["created_at"], name: "index_statuses_on_created_at"
    t.index ["e_no", "created_at"], name: "createdat_and_eno"
    t.index ["goodness"], name: "index_statuses_on_goodness"
    t.index ["int"], name: "index_statuses_on_int"
    t.index ["line"], name: "index_statuses_on_line"
    t.index ["mag"], name: "index_statuses_on_mag"
    t.index ["role_id"], name: "index_statuses_on_role_id"
    t.index ["sense"], name: "index_statuses_on_sense"
    t.index ["str"], name: "index_statuses_on_str"
    t.index ["used_ap"], name: "index_statuses_on_used_ap"
    t.index ["used_stp"], name: "index_statuses_on_used_stp"
    t.index ["vit"], name: "index_statuses_on_vit"
    t.index ["will"], name: "index_statuses_on_will"
  end

  create_table "uploaded_checks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
