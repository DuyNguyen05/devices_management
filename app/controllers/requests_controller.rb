# frozen_string_literal: true

class RequestsController < ApplicationController

  def new
    @request = Request.new
    if params[:query].present?
      @users = User.match_name_email(params[:query]).page(params[:page]).per(10)
    else
      @users = User.all.page(params[:page]).per(10)
    end
  end

  def create
    @request = Request.new request_params
    if @request.save
      @devices = Device.includes(:requests).page(params[:page]).per(10)
      respond_to do |format|
        format.js
      end
    else
      render "new"
    end
  end

  def edit
    @request = Request.find params[:id]
    respond_to do |format|
      format.js
    end
  end

  def update
    @request = Request.find params[:id]
    @request.update request_params
    respond_to do |format|
      format.js
    end
  end

  private

  def request_params
    params.require(:request).permit :created_at, :end_at, :user_id, :device_id
  end
end
