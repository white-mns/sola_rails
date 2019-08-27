class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.integer :e_no
      t.integer :str
      t.integer :vit
      t.integer :sense
      t.integer :agi
      t.integer :mag
      t.integer :int
      t.integer :will
      t.integer :charm
      t.integer :line
      t.integer :role_id
      t.integer :used_ap
      t.integer :used_stp
      t.integer :goodness

      t.timestamps
    end
  end
end
