class GoogleController < ApplicationController
  include GoogleHelper
  include AuthenticationHelper

  def new
    redirect_to login_url.to_s
  end

  def create
    user_tokens = get_tokens(params[:code])
    user_info = call_api('/oauth2/v2/userinfo', user_tokens['access_token'])

    user = User.where(:uid => user_info['id']).first
    if(user == nil)
      flash[:info] = "Register With Us"
      redirect_to new_user_path
    else
      session[:user_id] = user.id
      user.refresh_token = user_tokens['refresh_token']
      user.access_token = user_tokens['access_token']
      user.expires = user_tokens['expires_in']
      user.save
      session[:user_id] = user.id
    redirect_to (session[:redirect_to] || root_path)

    end
  end

  def destroy
    log_out
    session[:user_id] = nil
    redirect_to root_path
  end
end



