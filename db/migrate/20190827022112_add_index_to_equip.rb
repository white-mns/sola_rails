class AddIndexToEquip < ActiveRecord::Migration[5.2]
  def change
    add_index :equips, [:e_no, :created_at], :unique => false, :name => 'createdat_and_eno'
    add_index :equips, :artifact_id
    add_index :equips, :equip_num
    add_index :equips, :created_at
  end
end
