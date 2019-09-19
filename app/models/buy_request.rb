class BuyRequest < ApplicationRecord
  scope :search_buy_requests,
    lambda { |keyword| where("device_name LIKE :query OR reason LIKE :query OR state LIKE :query OR reference_link LIKE :query", query: "%#{keyword}%") }

  enum state: {pending: 0, waiting: 1, approved: 2, rejected: 3}

  belongs_to :user

  validates :device_name, presence: true
  validates :reason, presence: true
end
