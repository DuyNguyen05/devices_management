# frozen_string_literal: true

class Device < ApplicationRecord
  scope :search_device_by_name_or_code, lambda { |keyword|
                                          where(" name LIKE ?
                                            OR code LIKE ?", "%#{keyword}%", "%#{keyword}%")
                                        }

  has_many :requests, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  
end
