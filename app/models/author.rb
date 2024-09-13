class Author < ApplicationRecord
  has_many :books
  validates :nama, presence: true, uniqueness: { message: "sudah ada." }, length: { message: "harus lebih dari 3 karakter",minimum: 3, maximum: 100 }
end
