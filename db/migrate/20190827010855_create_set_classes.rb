class CreateSetClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :set_classes do |t|
      t.integer :e_no
      t.integer :class_id
      t.integer :class_num
      t.integer :lv

      t.timestamps
    end
  end
end
