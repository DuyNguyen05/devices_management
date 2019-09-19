class Tag < ApplicationRecord
  has_many :tag_requests
  has_many :requests, through: :tag_requests
end
