# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  # def create
  #   user = User.find_by email: params[:session][:email]
  #   if User && user.authenticate(params[:session][:password])
  #     flash[:success] = "Welcome"
  #     log_in(user)
  #     redirect_to user
  #   else
  #     flash[:danger] = "Invalid email/password"
  #     render :new
  #   end
  # end

  def create
    response = Faraday.get "https://github.com/login/oauth/access_token" do |resp|
      resp.params["client_id"] = ENV["client_id"]
      resp.params["client_secret"] = ENV["client_secret"]
      resp.params["grant_type"] = "authorization_code"
      resp.params["redirect_uri"] = "http://localhost:3000/auth"
      resp.params["code"] = params[:code]
    end
    body = JSON.parse(response.body)
    session[:token] = body["access_token"]
    redirect_to root_url
  end

  def destroy
    log_out
    flash[:success] = "Hope to see you again"
    redirect_to login_path
  end
end
