class CreateNuclears < ActiveRecord::Migration[5.2]
  def change
    create_table :nuclears do |t|
      t.integer :ap_no
      t.integer :e_no
      t.integer :skill_id
      t.string :user_name
      t.integer :turn
      t.integer :max_damage
      t.integer :total_damage

      t.timestamps
    end
  end
end
