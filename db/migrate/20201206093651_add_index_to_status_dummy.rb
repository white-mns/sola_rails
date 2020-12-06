class AddIndexToStatusDummy < ActiveRecord::Migration[6.0]
  def change
    add_index :status_dummies, [:e_no, :created_at], :unique => false, :name => 'createdat_and_eno'
  end
end
