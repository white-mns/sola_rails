class CreateLastArchives < ActiveRecord::Migration[6.0]
  def change
    create_table :last_archives do |t|
      t.integer :ap_no

      t.timestamps
    end
  end
end
