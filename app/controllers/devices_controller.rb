# frozen_string_literal: true

class DevicesController < ApplicationController

  def index
    if params[:keyword].present?
      @devices = Device.includes(:assigns).search_device_by_name_or_code params[:keyword]
    else
      @devices = Device.includes(:assigns).page(params[:page]).per(10)
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
      @devices = Device.all.page(params[:page]).per(10)
      respond_to do |format|
        format.js
      end
    else
      render "new"
    end
  end

  def show
    @device = Device.find params[:id]
  end

  def destroy
    @device = Device.find params[:id]
    @device.destroy
    @devices = Device.all.page(params[:page]).per(10)
    respond_to do |format|
      format.js
    end
  end

  private

  def device_params
    params.require(:device).permit :name, :code
  end

end
