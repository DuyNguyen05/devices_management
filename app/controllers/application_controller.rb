# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include GoogleHelper

  BASEURL = "http://localhost:3000/"

  CLIENT_ID = '913572984176-5gg40b6hebjvgil6cssr2o1fvuomvgq9.apps.googleusercontent.com'
  CLIENT_SECRET = 'pk96Znv0tou8U6AWy8NOMf05'
  CLIENT_SCOPE = 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/drive.readonly'
end
