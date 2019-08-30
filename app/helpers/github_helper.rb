module GithubHelper
  def authenticate_user
    client_id = ENV['client_id']
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    git_url = "https://github.com/login/oauth/access_token?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
    redirect_to git_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
