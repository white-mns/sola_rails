class StatusDummiesController < ApplicationController
  include MyUtility
  before_action :set_status_dummy, only: [:show, :edit, :update, :destroy]

  # GET /status_dummies
  def index
    placeholder_set
    param_set
    @count	= StatusDummy.notnil_date().includes(:pc_name).ransack(params[:q]).result.hit_count()
    @search	= StatusDummy.notnil_date().includes(:pc_name).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @status_dummies	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @last_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        params["created_at_gteq_form"] ||= @last_created.to_date.to_s
        params["created_at_lteq_form"] ||= @last_created.to_date.to_s
    end

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
  end
  # GET /status_dummies/1
  #def show
  #end

  # GET /status_dummies/new
  #def new
  #  @status_dummy = StatusDummy.new
  #end

  # GET /status_dummies/1/edit
  #def edit
  #end

  # POST /status_dummies
  #def create
  #  @status_dummy = StatusDummy.new(status_dummy_params)

  #  if @status_dummy.save
  #    redirect_to @status_dummy, notice: "Status dummy was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /status_dummies/1
  #def update
  #  if @status_dummy.update(status_dummy_params)
  #    redirect_to @status_dummy, notice: "Status dummy was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /status_dummies/1
  #def destroy
  #  @status_dummy.destroy
  #  redirect_to status_dummies_url, notice: "Status dummy was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status_dummy
      @status_dummy = StatusDummy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_dummy_params
      params.require(:status_dummy).permit(:e_no)
    end
end
