class AddIndexToSetClass < ActiveRecord::Migration[5.2]
  def change
    add_index :set_classes, [:e_no, :created_at], :unique => false, :name => 'createdat_and_eno'
    add_index :set_classes, :class_id
    add_index :set_classes, :class_num
    add_index :set_classes, :lv
  end
end
