class SkillsController < ApplicationController
  include MyUtility
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  # GET /skills
  def index
    placeholder_set
    param_set
    @count	= Skill.notnil_date().includes(:pc_name, [skill: [:cost, :timing]], [status: :role]).search(params[:q]).result.hit_count()
    @search	= Skill.notnil_date().includes(:pc_name, [skill: [:cost, :timing]], [status: :role]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @skills	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        params["created_at_gteq_form"] ||= @latest_created.to_date.to_s
        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "battle_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "set_no", params_name: "set_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")

    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_timing_id", params_name: "timing_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "text_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_is_artifact", params_name: "is_artifact_form", type: "number")

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_timing_name", params_name: "timing_form", type: "text")

    params_to_form(params, @form_params, column_name: "status_str", params_name: "str_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_vit", params_name: "vit_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_sense", params_name: "sense_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_agi", params_name: "agi_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_mag", params_name: "mag_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_int", params_name: "int_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_will", params_name: "will_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_charm", params_name: "charm_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_line", params_name: "line_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_role_id", params_name: "role_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_used_ap", params_name: "used_ap_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_used_stp", params_name: "used_stp_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_goodness", params_name: "goodness_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "is_pve", value: 0},
                                          {params_name: "is_pvp", value: 1}])

    checkbox_params_set_query_any(params, @form_params, query_name: "skill_range_eq_any",
                             checkboxes: [{params_name: "range_no", value: -1},
                                          {params_name: "range_random", value: -2}])

    params_to_form(params, @form_params, column_name: "skill_range", params_name: "range_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "skill_is_artifact_eq_any",
                             checkboxes: [{params_name: "no_artifact", value: 0},
                                          {params_name: "is_artifact", value: 1}])

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "status_role_id_eq_any",
                             checkboxes: [{params_name: "role_attacker", value: proper_name["アタッカー"]},
                                          {params_name: "role_tank",     value: proper_name["タンク"]},
                                          {params_name: "role_support",  value: proper_name["サポート"]},
                                          {params_name: "role_healer",   value: proper_name["ヒーラー"]},
                                          {params_name: "role_none",     value: proper_name["設定なし"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "status_line_eq_any",
                             checkboxes: [{params_name: "line_1", value: 1},
                                          {params_name: "line_2", value: 2},
                                          {params_name: "line_3", value: 3}])

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]

    toggle_params_to_variable(params, @form_params, params_name: "show_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill_detail")
    toggle_params_to_variable(params, @form_params, params_name: "show_status")
    toggle_params_to_variable(params, @form_params, params_name: "show_used")
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /skills/1
  #def show
  #end

  # GET /skills/new
  #def new
  #  @skill = Skill.new
  #end

  # GET /skills/1/edit
  #def edit
  #end

  # POST /skills
  #def create
  #  @skill = Skill.new(skill_params)

  #  if @skill.save
  #    redirect_to @skill, notice: "Skill was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /skills/1
  #def update
  #  if @skill.update(skill_params)
  #    redirect_to @skill, notice: "Skill was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /skills/1
  #def destroy
  #  @skill.destroy
  #  redirect_to skills_url, notice: "Skill was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_params
      params.require(:skill).permit(:e_no, :battle_type, :set_no, :skill_id, :name)
    end
end
