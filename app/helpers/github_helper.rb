# frozen_string_literal: true

module GithubHelper

  def link_github_login
    @login_url = GithubApi.link_github_login
  end

  def log_in_github(access_token)
    session[:access_token] = access_token
    auth_result = GithubApi.fetch_user_email(access_token)
    session[:email] = auth_result.parsed_response.first['email']
    if user = User.find_by(email: "#{session[:email]}")
      log_in user
      redirect_to root_path
    else
      flash[:info] = "Register With Us"
      redirect_to new_user_path
    end
    redirect_to users_path
  rescue => e
    session[:access_token] = nil
    return root_path
  end
end
