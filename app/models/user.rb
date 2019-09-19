# frozen_string_literal: true

class User < ApplicationRecord
  scope :match_name_email, lambda {|query| where("name LIKE ? OR email LIKE ? ", "%#{query}%", "%#{query}%")}

  has_many :requests, dependent: :destroy
  has_many :buy_requests

  has_secure_password
end
