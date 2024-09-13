class Book < ApplicationRecord
  belongs_to :author

  validates :judul, presence: true, uniqueness: { message: "buku sudah ada pemiliknya" }, length: { minimum: 3, maximum: 100, message: "harus lebih dari 3 karakter" }

  validates :author_id, presence: true

  validates :tahun_terbit, numericality: { message: "harus angka", only_integer: true, greater_than: 0, less_than_or_equal_to: Time.now.year }

  validate :tahun_terbit_tidak_lebih_dari_tahun_sekarang

  private

  def tahun_terbit_tidak_lebih_dari_tahun_sekarang
    if tahun_terbit.present? && tahun_terbit > Time.now.year
      errors.add(:tahun_terbit, "tidak boleh lebih dari tahun sekarang")
    end
  end
end
