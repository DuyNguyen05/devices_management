# frozen_string_literal: true

class GithubController < ApplicationController
  include GithubHelper

  def create
    session_code = request.env["rack.request.query_hash"]["code"]
    result = GithubApi.get_access_token(session_code)
    access_token = result.parsed_response["access_token"]
    log_in_github(access_token)
  end
end
