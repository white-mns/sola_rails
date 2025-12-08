class Skill < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :status, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Status'
	belongs_to :skill,  :foreign_key => :skill_id,  :primary_key => :skill_id,  :class_name => 'SkillDatum'

    scope :where_old_top, ->(last_result, show_old_top, params) {
        if show_old_top == "1" then
                skill_ids  = []

                params_copy = {}
                params_copy[:q] = {}
                params[:q].each do |key, value|
                    if key.include?("skill") || key.include?("e_no") || key.include?("pc_name") then
                        params_copy[:q][key] = value
                    end
                end

                # Ransack で where 検索だけ適用
                skills_filtered = Skill.where(created_at: params["old_rank_date_form"])
                                       .ransack(params_copy[:q])
                                       .result

                # 集計・ランキング（COUNT）は別で計算
                #    order には Arel.sql を使う
                top_skills = skills_filtered
                               .group(:skill_id)
                               .order(Arel.sql("COUNT(*) DESC"))
                               .limit(params["old_rank_num_form"].to_i)

                skill_ids << Hash[*top_skills.pluck(:skill_id).flat_map { |id| [id, nil] }].keys

            where(skill_id: skill_ids.flatten)
        end
    }

    scope :to_skill_history_graph, ->(params, column) {
        skill_name = Hash[*SkillDatum.pluck(:skill_id, :name).flatten]
        
        self.pluck(:created_at, column).inject(Hash.new(0)){|hash, a| 
            hash[ [skill_name[a[1]], a[0]] ] += 1;
            hash}
    }
end
