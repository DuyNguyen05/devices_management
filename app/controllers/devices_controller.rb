class DevicesController < ApplicationController

  before_action :set_pages, only: [:index, :create, :destroy]

  def index
    if params[:keyword].present?
      @devices = Device.includes(:requests).search_device_by_name_or_code params[:keyword]
    else
      @devices = Device.includes(:requests).paginate(@page)
      @total_page = Device.total_page
    end
  end

  def new
    @device = Device.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @device = Device.new device_params
    if @device.save
      @devices = Device.includes(:requests).paginate(@page)
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end

  def show
    @device = Device.includes(:requests).find params[:id]
  end

  def destroy
    @device = Device.find params[:id]
    @device.destroy
    @devices = Device.includes(:requests).paginate(@page)
    respond_to do |format|
      format.js
    end
  end

  private

  def device_params
    params.require(:device).permit :name, :code
  end

  def set_pages
    params[:page].blank? and return @page = 1
    @page = params[:page].to_i
  end
end
