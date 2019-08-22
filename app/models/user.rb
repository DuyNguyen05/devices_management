class User < ApplicationRecord
  has_secure_password

  def self.match_name_email(querry)
		if querry
			where("name LIKE ? OR email LIKE ? ", "%#{querry}%", "%#{querry}%")
		else
			where(nil)
		end	
	end
end
