class User < ApplicationRecord
  validates_presence_of :email, :username
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
