class AddIndexToAp < ActiveRecord::Migration[5.2]
  def change
    add_index :aps, :ap_no, :unique => true
    add_index :aps, [:created_at, :ap_no], :unique => false, :name => 'createdat_apno'
    add_index :aps, :battle_type_id
    add_index :aps, :party_num
    add_index :aps, :quest_id
    add_index :aps, :difficulty_id
    add_index :aps, :battle_result
    add_index :aps, :created_at
  end
end
