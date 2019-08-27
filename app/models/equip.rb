class Equip < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :artifact,   :foreign_key => :artifact_id,   :primary_key => :proper_id, :class_name => 'ProperName'
end
