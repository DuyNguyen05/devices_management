class TagRequest < ApplicationRecord
  belongs_to :tag
  belongs_to :request
end
