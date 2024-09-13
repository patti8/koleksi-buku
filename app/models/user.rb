class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         #:recoverable,
         :rememberable,
         :validatable
  validates :username, presence: true, uniqueness: { message: "sudah ada" }, length: { minimum: 3, maximum: 100, message: "harus lebih dari 3 karakter dan maksimal 100 karakter" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
