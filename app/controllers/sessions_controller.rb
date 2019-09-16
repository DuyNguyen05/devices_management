# frozen_string_literal: true

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email]
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Welcome"
      log_in(user)
      redirect_to user
    else
      flash[:danger] = "Invalid email/password"
      render "new"
    end
  end

  def destroy
    log_out
    flash[:success] = "Hope to see you again"
    redirect_to login_path
  end
end
