class NuclearsController < ApplicationController
  include MyUtility
  before_action :set_nuclear, only: [:show, :edit, :update, :destroy]

  # GET /nuclears
  def index
    placeholder_set
    param_set
    @count	= Nuclear.notnil_date().includes([ap: [:battle_type, :quest, :difficulty]], :skill, [party_members: :pc_name]).where_members(@params_members).where_leader(@params_leader).where_fellows(@params_fellows).where_rivals(@params_rivals).search(params[:q]).result.hit_count()
    @search	= Nuclear.notnil_date().includes([ap: [:battle_type, :quest, :difficulty]], :skill, [party_members: :pc_name]).where_members(@params_members).where_leader(@params_leader).where_fellows(@params_fellows).where_rivals(@params_rivals).page(params[:page]).search(params[:q])
    @search.sorts = "ap_no desc" if @search.sorts.empty?
    @nuclears	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @last_created = UploadedCheck.maximum("created_at")

    params_clean(params)

    @params_members = params.dup
    @params_leader  = params.dup
    @params_fellows = params.dup
    @params_rivals = params.dup
    @params_leader[:q]["party_order_eq"] = 0
    @params_leader[:q]["party_side_eq"] = 0
    @params_fellows[:q]["party_order_not_eq"] = 0
    @params_fellows[:q]["party_side_eq"] = 0
    @params_rivals[:q]["party_side_eq"] = 1

    if !params["is_form"] then
        params["created_at_lteq_form"] ||= @last_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "ap_no", params_name: "ap_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "user_name", params_name: "user_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "turn", params_name: "turn_form", type: "number")
    params_to_form(params, @form_params, column_name: "max_damage", params_name: "max_damage_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_damage", params_name: "total_damage_form", type: "number")

    params_to_form(params, @form_params, column_name: "ap_battle_type_id", params_name: "battle_type_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "ap_party_num", params_name: "party_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "ap_quest_id", params_name: "quest_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "ap_difficulty_id", params_name: "difficulty_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "ap_battle_result", params_name: "battle_result_form", type: "number")

    params_to_form(params, @form_params, column_name: "ap_quest_name", params_name: "quest_form", type: "text")

    params_to_form(@params_members, @form_params, column_name: "e_no", params_name: "party_members_e_no_form", type: "number")
    params_to_form(@params_members, @form_params, column_name: "pc_name_name", params_name: "party_members_name_form", type: "text")
    params_to_form(@params_leader, @form_params, column_name: "e_no", params_name: "leader_e_no_form", type: "number")
    params_to_form(@params_leader, @form_params, column_name: "pc_name_name", params_name: "leader_name_form", type: "text")
    params_to_form(@params_fellows, @form_params, column_name: "e_no", params_name: "fellow_members_e_no_form", type: "number")
    params_to_form(@params_fellows, @form_params, column_name: "pc_name_name", params_name: "fellow_members_name_form", type: "text")
    params_to_form(@params_rivals, @form_params, column_name: "e_no", params_name: "rival_members_e_no_form", type: "number")
    params_to_form(@params_rivals, @form_params, column_name: "pc_name_name", params_name: "rival_members_name_form", type: "text")
 
    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "ap_battle_type_id_eq_any",
                             checkboxes: [{params_name: "battle_main",  value: proper_name["メイン"]},
                                          {params_name: "battle_side",  value: proper_name["サイド"]},
                                          {params_name: "battle_quest", value: proper_name["クエスト"]},
                                          {params_name: "battle_pvp",   value: proper_name["摸擬戦"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "ap_difficulty_id_eq_any",
                             checkboxes: [{params_name: "difficulty_1", value: proper_name["ふつう"]},
                                          {params_name: "difficulty_2", value: proper_name["むずい"]},
                                          {params_name: "difficulty_3", value: proper_name["やばい"]},
                                          {params_name: "difficulty_4", value: proper_name["えぐい"]},
                                          {params_name: "difficulty_5", value: proper_name["じごく"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "ap_battle_result_eq_any",
                             checkboxes: [{params_name: "result_win",  value: 1},
                                          {params_name: "result_draw",  value: 0},
                                          {params_name: "result_lose",  value: -1},
                                          {params_name: "result_left",  value: 2},
                                          {params_name: "result_right",  value: -2}])

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]

    toggle_params_to_variable(params, @form_params, params_name: "show_ap")
    toggle_params_to_variable(params, @form_params, params_name: "show_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_ap_no")
    toggle_params_to_variable(params, @form_params, params_name: "show_date", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_battle_result")
    toggle_params_to_variable(params, @form_params, params_name: "show_leader_fellow")
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /nuclears/1
  #def show
  #end

  # GET /nuclears/new
  #def new
  #  @nuclear = Nuclear.new
  #end

  # GET /nuclears/1/edit
  #def edit
  #end

  # POST /nuclears
  #def create
  #  @nuclear = Nuclear.new(nuclear_params)

  #  if @nuclear.save
  #    redirect_to @nuclear, notice: "Nuclear was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /nuclears/1
  #def update
  #  if @nuclear.update(nuclear_params)
  #    redirect_to @nuclear, notice: "Nuclear was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /nuclears/1
  #def destroy
  #  @nuclear.destroy
  #  redirect_to nuclears_url, notice: "Nuclear was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nuclear
      @nuclear = Nuclear.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def nuclear_params
      params.require(:nuclear).permit(:ap_no, :e_no, :skill_id, :user_name, :turn, :max_damage, :total_damage)
    end
end
