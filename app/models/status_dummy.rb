class StatusDummy < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :main_class,         -> { where(class_num: 1)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
	belongs_to :sub1_class,         -> { where(class_num: 2)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
	belongs_to :sub2_class,         -> { where(class_num: 3)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
end
