# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :user
  belongs_to :device
  has_many :tag_requests
  has_many :tags, through: :tag_requests
  accepts_nested_attributes_for :tags
end
