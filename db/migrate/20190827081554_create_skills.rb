class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.integer :e_no
      t.integer :battle_type
      t.integer :set_no
      t.integer :skill_id
      t.string :name

      t.timestamps
    end
  end
end
