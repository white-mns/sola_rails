class AddCreatedAtIndexesToSkill < ActiveRecord::Migration[6.0]
  def change
    add_index :skills, [:created_at, :id], :unique => false, :name => 'createdat_and_id'
    add_index :skills, [:created_at, :battle_type, :skill_id], :unique => false, :name => 'createdat_and_battletype_and_skillid'
    add_index :skills, [:battle_type, :skill_id, :created_at], :unique => false, :name => 'battletype_and_skillid_and_createdat'
  end
end
