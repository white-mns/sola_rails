class AddIndexToSkillData < ActiveRecord::Migration[5.2]
  def change
    add_index :skill_data, :skill_id
    add_index :skill_data, :name
    add_index :skill_data, :range
    add_index :skill_data, :cost_id
    add_index :skill_data, :sp
    add_index :skill_data, :timing_id
    add_index :skill_data, :is_artifact
  end
end
