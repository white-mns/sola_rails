class TopPageController < ApplicationController
  def index
    @latest_updated = Status.maximum("updated_at")
    @uploaded_created = UploadedCheck.maximum("created_at")
  end
end
