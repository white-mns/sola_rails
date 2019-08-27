class SkillDatum < ApplicationRecord
	belongs_to :cost,   :foreign_key => :cost_id,   :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :timing, :foreign_key => :timing_id, :primary_key => :proper_id, :class_name => 'ProperName'
end
