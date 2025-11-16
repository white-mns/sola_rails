class SetClassesController < ApplicationController
  include MyUtility
  before_action :set_set_class, only: [:show, :edit, :update, :destroy]

  # GET /set_classes
  def index
    placeholder_set
    param_set
    @count	= SetClass.notnil_date().includes(:pc_name, :set_class).where(class_id: 1..Float::INFINITY).ransack(params[:q]).result.hit_count()
    @search	= SetClass.notnil_date().includes(:pc_name, :set_class).where(class_id: 1..Float::INFINITY).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @set_classes	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "class_id", params_name: "class_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "class_num", params_name: "class_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "lv", params_name: "lv_form", type: "number")

    params_to_form(params, @form_params, column_name: "class_name", params_name: "class_form", type: "text")

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "class_id_eq_any",
                             checkboxes: [{params_name: "class_fighter",         value: proper_name["ファイター"]},
                                          {params_name: "class_bushido",         value: proper_name["ブシドー"]},
                                          {params_name: "class_crusader",        value: proper_name["クルセイダー"]},
                                          {params_name: "class_war_leader",      value: proper_name["ウォーリーダー"]},
                                          {params_name: "class_shooter",         value: proper_name["シューター"]},
                                          {params_name: "class_thief",           value: proper_name["シーフ"]},
                                          {params_name: "class_ninja",           value: proper_name["ニンジャ"]},
                                          {params_name: "class_acrobat",         value: proper_name["アクロバット"]},
                                          {params_name: "class_mage",            value: proper_name["メイジ"]},
                                          {params_name: "class_sorcery_night",   value: proper_name["ソーサルナイト"]},
                                          {params_name: "class_enchanter",       value: proper_name["エンチャンター"]},
                                          {params_name: "class_shaman",          value: proper_name["シャーマン"]},
                                          {params_name: "class_priest",          value: proper_name["プリースト"]},
                                          {params_name: "class_time_shifter",    value: proper_name["タイムシフター"]},
                                          {params_name: "class_battle_bard",     value: proper_name["バトルバード"]},
                                          {params_name: "class_dancer",          value: proper_name["ダンサー"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "class_num_eq_any",
                             checkboxes: [{params_name: "class_main", value: 1},
                                          {params_name: "class_sub", value: 2},
                                          {params_name: "class_sub", value: 3}])

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]
  end
  # GET /set_classes/1
  #def show
  #end

  # GET /set_classes/new
  #def new
  #  @set_class = SetClass.new
  #end

  # GET /set_classes/1/edit
  #def edit
  #end

  # POST /set_classes
  #def create
  #  @set_class = SetClass.new(set_class_params)

  #  if @set_class.save
  #    redirect_to @set_class, notice: "Set class was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /set_classes/1
  #def update
  #  if @set_class.update(set_class_params)
  #    redirect_to @set_class, notice: "Set class was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /set_classes/1
  #def destroy
  #  @set_class.destroy
  #  redirect_to set_classes_url, notice: "Set class was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_set_class
      @set_class = SetClass.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def set_class_params
      params.require(:set_class).permit(:e_no, :class_id, :class_num, :lv)
    end
end
