class User < ApplicationRecord

  # use a before_save callback to downcase the email attribute before saving
  # the user
  before_save { self.email = email.downcase }
  # self refers to the current user, but inside the User model the self
  # keyword is optional on the right-hand side

  # method validates
  # validates(:name, presence: true)
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

    # we need to hash the password with bcrypt gem, then
    # we can add has_secure_password to our model
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

end
