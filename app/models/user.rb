# frozen_string_literal: true

class User < ApplicationRecord
  scope :match_name_email, lambda {|query| where("name LIKE ? OR email LIKE ? ", "%#{query}%", "%#{query}%")}
  has_secure_password
  has_many :requests, dependent: :destroy

  class << self
    def per_page
      10
    end

    def total_page(per_page = self.per_page)
      pages = (count / per_page.to_f).ceil
    end

    def paginate(page, per_page: self.per_page)
      page = page.to_i
      per_page = per_page.to_i

      offset = (page - 1) * per_page
      limit(per_page).offset(offset)
    end
  end
end
