class Status < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :role,   :foreign_key => :role_id,   :primary_key => :proper_id, :class_name => 'ProperName'
	has_many :equips, -> {order('equip_num ASC')}, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Equip'
    has_many :equips_pve,->       { where(battle_type: 0).order('equip_num ASC')}, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Equip'
    has_many :equips_pvp,->       { where(battle_type: 1).order('equip_num ASC')}, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Equip'
    has_many :equips_tale,->      { where(battle_type: 2).order('equip_num ASC')}, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Equip'
    has_many :equips_challenge,-> { where(battle_type: 3).order('equip_num ASC')}, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Equip'
	belongs_to :status_dummy,                                     :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'StatusDummy'
	belongs_to :main_class,         -> { where(class_num: 1)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
	belongs_to :sub1_class,         -> { where(class_num: 2)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
	belongs_to :sub2_class,         -> { where(class_num: 3)},    :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'SetClass'
end
