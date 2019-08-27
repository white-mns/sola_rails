class StatusesController < ApplicationController
  include MyUtility
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  def index
    placeholder_set
    param_set
    @count	= Status.notnil_date().includes(:pc_name, :role).search(params[:q]).result.hit_count()
    @search	= Status.notnil_date().includes(:pc_name, :role).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @statuses	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "str", params_name: "str_form", type: "number")
    params_to_form(params, @form_params, column_name: "vit", params_name: "vit_form", type: "number")
    params_to_form(params, @form_params, column_name: "sense", params_name: "sense_form", type: "number")
    params_to_form(params, @form_params, column_name: "agi", params_name: "agi_form", type: "number")
    params_to_form(params, @form_params, column_name: "mag", params_name: "mag_form", type: "number")
    params_to_form(params, @form_params, column_name: "int", params_name: "int_form", type: "number")
    params_to_form(params, @form_params, column_name: "will", params_name: "will_form", type: "number")
    params_to_form(params, @form_params, column_name: "charm", params_name: "charm_form", type: "number")
    params_to_form(params, @form_params, column_name: "line", params_name: "line_form", type: "number")
    params_to_form(params, @form_params, column_name: "role_id", params_name: "role_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "used_ap", params_name: "used_ap_form", type: "number")
    params_to_form(params, @form_params, column_name: "used_stp", params_name: "used_stp_form", type: "number")
    params_to_form(params, @form_params, column_name: "goodness", params_name: "goodness_form", type: "number")

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "role_id_eq_any",
                             checkboxes: [{params_name: "role_attacker", value: proper_name["アタッカー"]},
                                          {params_name: "role_tank",     value: proper_name["タンク"]},
                                          {params_name: "role_support",  value: proper_name["サポート"]},
                                          {params_name: "role_healer",   value: proper_name["ヒーラー"]},
                                          {params_name: "role_none",     value: proper_name["設定なし"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "line_eq_any",
                             checkboxes: [{params_name: "line_1", value: 1},
                                          {params_name: "line_2", value: 2},
                                          {params_name: "line_3", value: 3}])

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]

    toggle_params_to_variable(params, @form_params, params_name: "show_used")
  end
  # GET /statuses/1
  #def show
  #end

  # GET /statuses/new
  #def new
  #  @status = Status.new
  #end

  # GET /statuses/1/edit
  #def edit
  #end

  # POST /statuses
  #def create
  #  @status = Status.new(status_params)

  #  if @status.save
  #    redirect_to @status, notice: "Status was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /statuses/1
  #def update
  #  if @status.update(status_params)
  #    redirect_to @status, notice: "Status was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /statuses/1
  #def destroy
  #  @status.destroy
  #  redirect_to statuses_url, notice: "Status was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_params
      params.require(:status).permit(:e_no, :str, :vit, :sense, :agi, :mag, :int, :will, :charm, :line, :role_id, :used_ap, :used_stp, :goodness)
    end
end
