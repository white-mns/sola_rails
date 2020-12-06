class CreateStatusDummies < ActiveRecord::Migration[6.0]
  def change
    create_table :status_dummies do |t|
      t.integer :e_no

      t.timestamps
    end
  end
end
