class TitlesController < ApplicationController
  include MyUtility
  before_action :set_title, only: [:show, :edit, :update, :destroy]

  # GET /titles
  def index
    placeholder_set
    param_set
    @count	= Title.notnil_date().includes(:pc_name).ransack(params[:q]).result.hit_count()
    @search	= Title.notnil_date().includes(:pc_name).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @titles	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "title", params_name: "title_form", type: "text")

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]
  end
  # GET /titles/1
  #def show
  #end

  # GET /titles/new
  #def new
  #  @title = Title.new
  #end

  # GET /titles/1/edit
  #def edit
  #end

  # POST /titles
  #def create
  #  @title = Title.new(title_params)

  #  if @title.save
  #    redirect_to @title, notice: "Title was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /titles/1
  #def update
  #  if @title.update(title_params)
  #    redirect_to @title, notice: "Title was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /titles/1
  #def destroy
  #  @title.destroy
  #  redirect_to titles_url, notice: "Title was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_title
      @title = Title.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def title_params
      params.require(:title).permit(:e_no, :title)
    end
end
