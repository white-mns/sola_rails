class AddIndexToNuclear < ActiveRecord::Migration[5.2]
  def change
    add_index :nuclears, :ap_no
    add_index :nuclears, :e_no
    add_index :nuclears, :skill_id
    add_index :nuclears, :user_name
    add_index :nuclears, :turn
    add_index :nuclears, :max_damage
    add_index :nuclears, :total_damage
  end
end
