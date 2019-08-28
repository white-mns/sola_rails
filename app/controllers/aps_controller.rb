class ApsController < ApplicationController
  include MyUtility
  before_action :set_ap, only: [:show, :edit, :update, :destroy]

  # GET /aps
  def index
    placeholder_set
    param_set
    @count	= Ap.notnil_date().includes(:battle_type, :quest, :difficulty).search(params[:q]).result.hit_count()
    @search	= Ap.notnil_date().includes(:battle_type, :quest, :difficulty).page(params[:page]).search(params[:q])
    @search.sorts = "ap_no desc" if @search.sorts.empty?
    @aps	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "ap_no", params_name: "ap_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_type_id", params_name: "battle_type_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_num", params_name: "party_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "quest_id", params_name: "quest_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "difficulty_id", params_name: "difficulty_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_result", params_name: "battle_result_form", type: "number")

    params_to_form(params, @form_params, column_name: "quest_name", params_name: "quest_form", type: "text")

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_id_eq_any",
                             checkboxes: [{params_name: "battle_main",  value: proper_name["メイン"]},
                                          {params_name: "battle_side",  value: proper_name["サイド"]},
                                          {params_name: "battle_quest", value: proper_name["クエスト"]},
                                          {params_name: "battle_pvp",   value: proper_name["摸擬戦"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "difficulty_id_eq_any",
                             checkboxes: [{params_name: "difficulty_1", value: proper_name["ふつう"]},
                                          {params_name: "difficulty_2", value: proper_name["むずい"]},
                                          {params_name: "difficulty_3", value: proper_name["やばい"]},
                                          {params_name: "difficulty_4", value: proper_name["えぐい"]},
                                          {params_name: "difficulty_5", value: proper_name["じごく"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_result_eq_any",
                             checkboxes: [{params_name: "result_win",  value: 1},
                                          {params_name: "result_draw",  value: 0},
                                          {params_name: "result_lose",  value: -1},
                                          {params_name: "result_left",  value: 2},
                                          {params_name: "result_right",  value: -2}])

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]

    toggle_params_to_variable(params, @form_params, params_name: "show_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_ap_no")
    toggle_params_to_variable(params, @form_params, params_name: "show_date", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_battle_result", first_opened: true)
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /aps/1
  #def show
  #end

  # GET /aps/new
  #def new
  #  @ap = Ap.new
  #end

  # GET /aps/1/edit
  #def edit
  #end

  # POST /aps
  #def create
  #  @ap = Ap.new(ap_params)

  #  if @ap.save
  #    redirect_to @ap, notice: "Ap was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /aps/1
  #def update
  #  if @ap.update(ap_params)
  #    redirect_to @ap, notice: "Ap was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /aps/1
  #def destroy
  #  @ap.destroy
  #  redirect_to aps_url, notice: "Ap was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ap
      @ap = Ap.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ap_params
      params.require(:ap).permit(:ap_no, :battle_type_id, :party_num, :quest_id, :difficulty_id, :battle_result)
    end
end
