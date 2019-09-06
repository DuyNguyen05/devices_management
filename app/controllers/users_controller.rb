# frozen_string_literal: true

class UsersController < ApplicationController

  def index
    if params[:query].present?
      @users = User.match_name_email(params[:query]).page(params[:page])
    else
      @users = User.all.page(params[:page]).per(10)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @users = User.page(params[:page]).per(10)
      flash[:success] = "Register Success"
      redirect_to users_path
    else
      flash[:danger] = "Fail"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end

  def destroy
    @user.destroy
    @users = User.page(params[:page]).per(10)
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
