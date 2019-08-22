class UsersController < ApplicationController

  def index
    @users = User.match_name_email(params[:match_name_email])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
