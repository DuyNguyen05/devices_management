class User < ApplicationRecord
  has_secure_password

  def self.match_name_email(query)
    if querry
      where("name LIKE ? OR email LIKE ? ", "%#{query}%", "%#{query}%")
    else
      where(nil)
    end
  end
end
