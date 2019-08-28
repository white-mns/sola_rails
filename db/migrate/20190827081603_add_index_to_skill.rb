class AddIndexToSkill < ActiveRecord::Migration[5.2]
  def change
    add_index :skills, [:e_no, :created_at, :set_no], :unique => false, :name => 'createdat_and_eno'
    add_index :skills, :battle_type
    add_index :skills, :skill_id
  end
end
