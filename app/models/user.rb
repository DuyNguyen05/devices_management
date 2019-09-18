# frozen_string_literal: true

class User < ApplicationRecord
  scope :match_name_email, lambda { |query| where("name LIKE ? OR email LIKE ? ", "%#{query}%", "%#{query}%") }
  has_secure_password
  has_many :assigns, dependent: :destroy
end
