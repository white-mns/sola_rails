class CreateAps < ActiveRecord::Migration[5.2]
  def change
    create_table :aps do |t|
      t.integer :ap_no
      t.integer :battle_type_id
      t.integer :party_num
      t.integer :quest_id
      t.integer :difficulty_id
      t.integer :battle_result

      t.timestamps
    end
  end
end
