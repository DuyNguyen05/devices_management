# frozen_string_literal: true

class RequestsController < ApplicationController

  def new
    @request = Request.new
    @device = Device.find params[:device_id] if params[:device_id].present?
    if params[:query].present?
      @users = User.match_name_email(params[:query]).page(params[:page]).per(10)
    else
      @users = User.all.page(params[:page]).per(10)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @request = Request.new request_params
    if @request.save
      respond_to do |format|
        format.js { flash[:success] = t(".assign") }
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
    @user = User.find_by(email: params[:request][:user])
    @request.update request_params.merge(user_id: @user.id)
    respond_to do |format|
      format.js
    end
  end

  def load_user
    if params[:query]
      @users = User.match_name_email(params[:query])
      render json: { users: @users.map { |user| user.email }}
    end
  end

  private

  def request_params
    params.require(:request).permit :created_at, :end_at, :user_id, :device_id
  end
end
