# frozen_string_literal: true

class SessionsController < ApplicationController

def new
  redirect_to login_url.to_s
end

def create
  user_tokens = get_tokens(params[:code])
  
  user_info = call_api('/oauth2/v2/userinfo', user_tokens['access_token'])

  user = User.where(:uid => user_info['id']).first

  if(user == nil)
    user = User.create!(:password => '12345678', password_confirmation: '12345678', :email => user_info['email'], :name => user_info['given_name'], :uid => user_info['id'], :refresh_token => user_tokens['refresh_token'], :access_token => user_tokens['access_token'], :expires => user_tokens['expires'])
    session[:user_id] = user.id
  else
    user.refresh_token = user_tokens['refresh_token']
    user.access_token = user_tokens['access_token']
    user.expires = user_tokens['expires_in']
    user.save
    session[:user_id] = user.id
  end
  
  redirect_to session[:redirect_to] ||= root_path
end

def destroy
  log_out
  session[:user_id] = nil
  redirect_to root_path
end

end