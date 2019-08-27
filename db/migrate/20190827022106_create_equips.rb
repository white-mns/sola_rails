class CreateEquips < ActiveRecord::Migration[5.2]
  def change
    create_table :equips do |t|
      t.integer :e_no
      t.integer :artifact_id
      t.integer :equip_num

      t.timestamps
    end
  end
end
