class AddIndexToTitle < ActiveRecord::Migration[6.0]
  def change
    add_index :titles, [:e_no, :created_at, :title], :unique => false, :name => 'createdat_and_eno'
    add_index :titles, :title
  end
end
