class User < ApplicationRecord
  scope :match_name_email, -> (query) {where("name LIKE ? OR email LIKE ? ", "%#{query}%", "%#{query}%")}
  has_secure_password
  has_many :requests, dependent: :destroy
end
