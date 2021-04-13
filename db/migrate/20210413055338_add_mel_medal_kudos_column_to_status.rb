class AddMelMedalKudosColumnToStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :statuses, :mel, :integer
    add_column :statuses, :medal, :integer
    add_column :statuses, :kudos, :integer
    add_index  :statuses, :mel
    add_index  :statuses, :medal
    add_index  :statuses, :kudos
  end
end
