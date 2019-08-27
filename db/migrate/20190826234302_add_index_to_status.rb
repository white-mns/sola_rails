class AddIndexToStatus < ActiveRecord::Migration[5.2]
  def change
    add_index :statuses, [:e_no, :created_at], :unique => false, :name => 'createdat_and_eno'
    add_index :statuses, :str
    add_index :statuses, :vit
    add_index :statuses, :sense
    add_index :statuses, :agi
    add_index :statuses, :mag
    add_index :statuses, :int
    add_index :statuses, :will
    add_index :statuses, :charm
    add_index :statuses, :line
    add_index :statuses, :role_id
    add_index :statuses, :used_ap
    add_index :statuses, :used_stp
    add_index :statuses, :goodness
    add_index :statuses, :created_at
  end
end
