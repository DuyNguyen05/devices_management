# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :load_user

  def new
    @request = Request.new
    respond_to do |format|
      format.js
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

  def load_user
    @users = User.pluck :name, :id
  end
end
