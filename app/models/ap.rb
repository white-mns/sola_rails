class Ap < ApplicationRecord
	belongs_to :battle_type, :foreign_key => :battle_type_id, :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :quest,       :foreign_key => :quest_id,       :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :difficulty,  :foreign_key => :difficulty_id,  :primary_key => :proper_id, :class_name => 'ProperName'
	has_many :party_members, -> {order('party_order ASC')}, :foreign_key => :ap_no, :primary_key => :ap_no, :class_name => 'Party'

    scope :where_members, -> (params) {
        if params["party_members_e_no_form"] || params["party_members_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:ap_no)
            where(ap_no: query)
        end
    }

    scope :where_leader, -> (params) {
        if params["leader_e_no_form"] || params["leader_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:ap_no)
            where(ap_no: query)
        end
    }

    scope :where_fellows, -> (params) {
        if params["fellow_members_e_no_form"] || params["fellow_members_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:ap_no)
            where(ap_no: query)
        end
    }

    scope :where_rivals, -> (params) {
        if params["rival_members_e_no_form"] || params["rival_members_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:ap_no)
            where(ap_no: query)
        end
    }


end
