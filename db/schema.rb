# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_16_035510) do

  create_table "aps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.integer "battle_type_id"
    t.integer "party_num"
    t.integer "quest_id"
    t.integer "difficulty_id"
    t.integer "battle_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ap_no"], name: "index_aps_on_ap_no", unique: true
    t.index ["battle_result"], name: "index_aps_on_battle_result"
    t.index ["battle_type_id"], name: "index_aps_on_battle_type_id"
    t.index ["created_at", "ap_no"], name: "createdat_apno"
    t.index ["created_at"], name: "index_aps_on_created_at"
    t.index ["difficulty_id"], name: "index_aps_on_difficulty_id"
    t.index ["party_num"], name: "index_aps_on_party_num"
    t.index ["quest_id"], name: "index_aps_on_quest_id"
  end

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

  create_table "last_archives", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_no"], name: "index_names_on_e_no"
    t.index ["name"], name: "index_names_on_name"
  end

  create_table "new_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_new_skills_on_created_at"
    t.index ["skill_id"], name: "index_new_skills_on_skill_id"
  end

  create_table "nuclears", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.integer "e_no"
    t.integer "skill_id"
    t.string "user_name"
    t.integer "turn"
    t.integer "max_damage"
    t.integer "total_damage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ap_no"], name: "index_nuclears_on_ap_no"
    t.index ["e_no"], name: "index_nuclears_on_e_no"
    t.index ["max_damage"], name: "index_nuclears_on_max_damage"
    t.index ["skill_id"], name: "index_nuclears_on_skill_id"
    t.index ["total_damage"], name: "index_nuclears_on_total_damage"
    t.index ["turn"], name: "index_nuclears_on_turn"
    t.index ["user_name"], name: "index_nuclears_on_user_name"
  end

  create_table "parties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.integer "e_no"
    t.integer "party_side"
    t.integer "party_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ap_no", "e_no"], name: "apno_eno"
    t.index ["party_order"], name: "index_parties_on_party_order"
    t.index ["party_side"], name: "index_parties_on_party_side"
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
    t.index ["battle_type", "skill_id", "created_at"], name: "battletype_and_skillid_and_createdat"
    t.index ["battle_type"], name: "index_skills_on_battle_type"
    t.index ["created_at", "battle_type", "skill_id"], name: "createdat_and_battletype_and_skillid"
    t.index ["created_at", "id"], name: "createdat_and_id"
    t.index ["e_no", "created_at", "set_no"], name: "createdat_and_eno"
    t.index ["skill_id"], name: "index_skills_on_skill_id"
  end

  create_table "status_dummies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["e_no", "created_at"], name: "createdat_and_eno"
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

  create_table "titles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["e_no", "created_at", "title"], name: "createdat_and_eno"
    t.index ["title"], name: "index_titles_on_title"
  end

  create_table "uploaded_checks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
