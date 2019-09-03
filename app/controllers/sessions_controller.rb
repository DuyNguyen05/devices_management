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
      user = User.create(:email => user_info['email'],
       :first_name => user_info['given_name'], :last_name => user_info['family_name'], :role => 'User', :uid => user_info['id'], :refresh_token => user_tokens['refresh_token'], :access_token => user_tokens['access_token'], :expires => user_tokens['expires_in'])
          session[:user_id] = user.id
    else
      user.refresh_token = user_tokens['refresh_token']
      user.access_token = user_tokens['access_token']
      user.expires = user_tokens['expires']
      user.save

      session[:user_id] = user.id
      redirect_to session[:redirect_to] ||= root_path
    end
  end




    # user = User.find_by email: params[:session][:email]
    # if User && user.authenticate(params[:session][:password])
    #   flash[:success] = "Welcome"
    #   log_in(user)
    #   redirect_to user
    # else
    #   flash[:danger] = "Invalid email/password"
    #   render :new
    # end
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    # log_out
    # flash[:success] = "Hope to see you again"
    # redirect_to login_path
  end
end
