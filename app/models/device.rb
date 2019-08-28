# frozen_string_literal: true

class Device < ApplicationRecord
  scope :search_device_by_name_or_code, lambda { |keyword|
                                          where(" name LIKE ?
                                            OR code LIKE ?", "%#{keyword}%", "%#{keyword}%")
                                        }

  has_many :requests, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

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
