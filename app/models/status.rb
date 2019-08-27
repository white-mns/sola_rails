class Status < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :role,   :foreign_key => :role_id,   :primary_key => :proper_id, :class_name => 'ProperName'
end
