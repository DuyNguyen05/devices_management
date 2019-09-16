# frozen_string_literal: true

module GoogleHelper

  def login_url
    redirect_uri = ENV["BASEURL"] + "oauth2callback"

    url = "https://accounts.google.com/o/oauth2/auth?" +
          "scope=" + ENV["GOOGLE_CLIENT_SCOPE"]+ "&" +
          "redirect_uri=" + redirect_uri + "&" +
          "response_type=code&" +
          "client_id=" + ENV["GOOGLE_CLIENT_ID"] + "&" +
          "access_type=offline"

    URI.parse(URI.encode(url.strip))
  end

  def get_tokens(code)

    params["code"] = code
    params["client_id"] = ENV["GOOGLE_CLIENT_ID"]
    params["client_secret"] = ENV["GOOGLE_CLIENT_SECRET"]
    params["redirect_uri"] = ENV["BASEURL"] + "oauth2callback"
    params["grant_type"] = "authorization_code"

    # Initialize HTTP library
    url = HTTParty.get("https://accounts.google.com").to_json

    # Make request for tokens
    request = HTTParty.post("https://accounts.google.com/o/oauth2/token",
                body: {code: code, client_id: ENV["GOOGLE_CLIENT_ID"], client_secret: ENV["GOOGLE_CLIENT_SECRET"], redirect_uri: ENV["BASEURL"] + "oauth2callback", grant_type: "authorization_code" }.to_json,
                headers: { "Content-Type" => "application/json", "Accept" => "application/json"})
    return request


  end

  def refresh_token(user_id)

    user = User.find(user_id)

    params["refresh_token"] = user.refresh_token
    params["client_id"] = ENV["GOOGLE_CLIENT_ID"]
    params["client_secret"] = ENV["GOOGLE_CLIENT_SECRET"]
    params["grant_type"] = "refresh_token"

    # Initialize HTTP library
    url = HTTParty.get("https://accounts.google.com").to_json

    # Make request for tokens
    request = HTTParty.post("https://accounts.google.com/o/oauth2/token",
      body: {code: code, client_id: ENV["GOOGLE_CLIENT_ID"], client_secret: ENV["GOOGLE_CLIENT_SECRET"], redirect_uri: ENV["BASEURL"] + "oauth2callback", grant_type: "authorization_code" }.to_json,
      headers: { "Content-Type" => "application/json", "Accept" => "application/json"})
    # Parse the response
    user_tokens = request

    # Save the new access_token to the user
    user.access_token = user_tokens["access_token"]
    user.expires = user_tokens["expires_in"]
    user.save

    # Return the new access_token
    user_tokens["access_token"]

  end

  def valid_token?(access_token)

    path = "/oauth2/v1/tokeninfo"

    # Initialize HTTP library
    url = HTTParty.get("https://accounts.google.com/oauth2/v1/tokeninfo").to_json

    # Make request to API
    request = HTTParty.get("https://accounts.google.com/oauth2/v1/tokeninfo",
              headers: {'Authorization': "Bearer" + access_token})

    return requests

    if(result["error"] != nil && result["error"] == "invalid_token")
      false
    else
      true
    end
  end

  def call_api(path, access_token)

    # Initialize HTTP library
    url = HTTParty.get("https://www.googleapis.com").to_json

    # Make request to API

    request = HTTParty.get("https://www.googleapis.com" + path,
              headers: {'Authorization': "Bearer" + access_token})
    return request
  end
end
