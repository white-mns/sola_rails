class AddBattleTypeColumnToEquip < ActiveRecord::Migration[6.0]
  def change
    add_column :equips, :battle_type, :integer
    add_index  :equips, :battle_type
  end
end
