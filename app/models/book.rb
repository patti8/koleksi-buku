class Book < ApplicationRecord
  belongs_to :author
  validates_uniqueness_of :judul, on: :create, message: "buku sudah ada pemiliknya"
  validates :tahun_terbit, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: Time.now.year }
end
