# frozen_string_literal: true

class Device < ApplicationRecord
  after_initialize :set_buyer

  enum condition: {
    avaiable: 0,
    unavaiable: 1,
    out_of_order: 2,
  }
  scope :search_device_by_name_or_code, lambda { |keyword|
                                          where(" name LIKE ?
                                            OR code LIKE ?", "%#{keyword}%", "%#{keyword}%")
                                        }

  has_many :requests, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  private
  def set_buyer
    self.user_id ||= 5
  end
end
