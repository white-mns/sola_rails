class LastArchivesController < ApplicationController
  include MyUtility
  before_action :set_last_archive, only: [:show, :edit, :update, :destroy]

  # GET /last_archives
  def index
    placeholder_set
    param_set
    @count	= LastArchive.notnil_date().ransack(params[:q]).result.hit_count()
    @search	= LastArchive.notnil_date().page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @last_archives	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @last_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        params["created_at_lteq_form"] ||= @last_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "ap_no", params_name: "ap_no_form", type: "number")
  end
  # GET /last_archives/1
  #def show
  #end

  # GET /last_archives/new
  #def new
  #  @last_archive = LastArchive.new
  #end

  # GET /last_archives/1/edit
  #def edit
  #end

  # POST /last_archives
  #def create
  #  @last_archive = LastArchive.new(last_archive_params)

  #  if @last_archive.save
  #    redirect_to @last_archive, notice: "Last archive was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /last_archives/1
  #def update
  #  if @last_archive.update(last_archive_params)
  #    redirect_to @last_archive, notice: "Last archive was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /last_archives/1
  #def destroy
  #  @last_archive.destroy
  #  redirect_to last_archives_url, notice: "Last archive was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_last_archive
      @last_archive = LastArchive.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def last_archive_params
      params.require(:last_archive).permit(:ap_no)
    end
end
