class Skill < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :status, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Status'
	belongs_to :skill,  :foreign_key => :skill_id,  :primary_key => :skill_id,  :class_name => 'SkillDatum'
end
