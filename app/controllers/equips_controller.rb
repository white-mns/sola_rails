class EquipsController < ApplicationController
  include MyUtility
  before_action :set_equip, only: [:show, :edit, :update, :destroy]

  # GET /equips
  def index
    placeholder_set
    param_set
    @count	= Equip.notnil_date().includes(:pc_name, :artifact).where(artifact_id: 1..Float::INFINITY).ransack(params[:q]).result.hit_count()
    @search	= Equip.notnil_date().includes(:pc_name, :artifact).where(artifact_id: 1..Float::INFINITY).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @equips	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @last_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        params["created_at_gteq_form"] ||= @last_created.to_date.to_s
        params["created_at_lteq_form"] ||= @last_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "artifact_id", params_name: "artifact_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "equip_num", params_name: "equip_num_form", type: "number")

    params_to_form(params, @form_params, column_name: "artifact_name", params_name: "artifact_form", type: "text")

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]
  end
  # GET /equips/1
  #def show
  #end

  # GET /equips/new
  #def new
  #  @equip = Equip.new
  #end

  # GET /equips/1/edit
  #def edit
  #end

  # POST /equips
  #def create
  #  @equip = Equip.new(equip_params)

  #  if @equip.save
  #    redirect_to @equip, notice: "Equip was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /equips/1
  #def update
  #  if @equip.update(equip_params)
  #    redirect_to @equip, notice: "Equip was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /equips/1
  #def destroy
  #  @equip.destroy
  #  redirect_to equips_url, notice: "Equip was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equip
      @equip = Equip.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def equip_params
      params.require(:equip).permit(:e_no, :equip_id, :equip_num)
    end
end
