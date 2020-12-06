class StatusDummy < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :main_class,         -> { where(class_num: 1)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
	belongs_to :sub1_class,         -> { where(class_num: 2)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
	belongs_to :sub2_class,         -> { where(class_num: 3)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
end
