class AddIndexToName < ActiveRecord::Migration[5.2]
  def change
    add_index :names, :e_no
    add_index :names, :name
  end
end
