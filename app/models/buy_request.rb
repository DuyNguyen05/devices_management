class BuyRequest < ApplicationRecord
  scope :search_buy_requests_by_device_name_or_reason_or_state,
    lambda { |keyword| where("device_name LIKE :query OR reason LIKE :query OR state LIKE :query", query: "#{keyword}") }

  enum state: {pending: 0, waiting: 1, approved: 2, rejected: 3}

  belongs_to :user
end
