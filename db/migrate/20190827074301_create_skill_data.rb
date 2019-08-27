class CreateSkillData < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_data do |t|
      t.integer :skill_id
      t.string :name
      t.integer :range
      t.integer :cost_id
      t.integer :sp
      t.integer :timing_id
      t.string :text
      t.integer :is_artifact

      t.timestamps
    end
  end
end
