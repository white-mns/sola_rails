class AddIndexToNewSkill < ActiveRecord::Migration[5.2]
  def change
    add_index :new_skills, :skill_id
    add_index :new_skills, :created_at
  end
end
