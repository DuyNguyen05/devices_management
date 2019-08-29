# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_pages, only: %i[index create destroy]

  def index
    if params[:query].present?
      @users = User.match_name_email params[:query]
    else
      @users = User.paginate(@page)
      @total_page = User.total_page
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @users = User.paginate(@page)
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
    @users = User.paginate(@page)
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_pages
    params[:page].blank? && (return @page = 1)
    @page = params[:page].to_i
  end
end
