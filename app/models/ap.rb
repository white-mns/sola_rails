class Ap < ApplicationRecord
	belongs_to :battle_type, :foreign_key => :battle_type_id, :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :quest,       :foreign_key => :quest_id,       :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :difficulty,  :foreign_key => :difficulty_id,  :primary_key => :proper_id, :class_name => 'ProperName'
end
