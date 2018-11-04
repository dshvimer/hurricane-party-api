class User < ApplicationRecord

  has_secure_password

  has_many :posts

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: true }

  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || (!password.nil?) }


  def self.from_token_request(request)
    username = request.params["auth"] && request.params["auth"]["username"]
    self.find_by username: username
  end

  def generate_token
    Knock::AuthToken.new(payload: { sub: id }).token
  end
end
