require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(judul: Faker::Book.title, tahun_terbit: 2001, author: Author.create(nama:  Faker::Name.name))
  end

  test "should be valid" do
    assert @book.valid?
  end

  # Test judul harus ada
  test "judul should be present" do
    @book.judul = nil
    assert_not @book.valid?, "Book is valid without a judul"
    assert_includes @book.errors[:judul], "can't be blank", "Error message for blank judul is missing"
  end

  # Test judul harus unik
  test "judul should be unique" do
    duplicate_book = @book.dup
    @book.save
    assert_not duplicate_book.valid?, "Duplicate book is valid with the same judul"
    assert_includes duplicate_book.errors[:judul], "buku sudah ada pemiliknya"
  end

  # Test tahun_terbit harus angka
  test "tahun_terbit should be valid" do
    @book.tahun_terbit = "invalid"
    assert_not @book.valid?, "Book is valid with non-numeric tahun terbit"
    assert_includes @book.errors[:tahun_terbit], "is not a number"

    @book.tahun_terbit = -1
    assert_not @book.valid?, "Book is valid with negative tahun_terbit"
    assert_includes @book.errors[:tahun_terbit], "must be greater than 0"

    @book.tahun_terbit = Time.now.year + 1
    assert_not @book.valid?, "Book is valid with future tahun_terbit"
    assert_includes @book.errors[:tahun_terbit], "must be less than or equal to #{Time.now.year}"
  end

  # Test relasi dengan author
  test "should belong to author" do
    assert @book.author.present?, "Book does not have an associated author"
  end
end
