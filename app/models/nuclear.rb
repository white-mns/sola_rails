class Nuclear < ApplicationRecord
	belongs_to :ap, :foreign_key => :ap_no, :primary_key => :ap_no, :class_name => 'Ap'
	belongs_to :skill,  :foreign_key => :skill_id,  :primary_key => :skill_id,  :class_name => 'SkillDatum'
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
