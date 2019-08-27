class SetClass < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :set_class,   :foreign_key => :class_id,   :primary_key => :proper_id, :class_name => 'ProperName'
end
