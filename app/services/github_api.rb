# frozen_string_literal: true

class GithubApi
  class << self
    def link_github_login
      "https://github.com/login/oauth/authorize?scope=user:email&client_id=#{ENV["GITHUB_CLIENT_ID"]}"
    end

    def get_access_token(session_code)
      HTTParty.post("https://github.com/login/oauth/access_token", body: {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_KEY"], code: session_code}.to_json, headers: { "Content-Type" => "application/json",  "Accept" => "application/json" })
    end

    def fetch_user_email(access_token)
      HTTParty.get("https://api.github.com/user/emails", {query: {access_token: access_token}, format: :json})
    end
  end
end
