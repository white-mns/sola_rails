class CreateTitles < ActiveRecord::Migration[6.0]
  def change
    create_table :titles do |t|
      t.integer :e_no
      t.string :title

      t.timestamps
    end
  end
end
