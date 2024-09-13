require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  def setup
    @author = Author.new(nama: "J.K. Rowling")
  end

  # Uji validasi nama yang valid
  test "nama should be valid" do
    valid_names = %w[Stephen King Tendy Tolkien Agatha Christie]
    valid_names.each do |valid_name|
      @author.nama = valid_name
      assert @author.valid?, "#{valid_name.inspect} should be valid"
    end
  end

  # Uji validasi nama yang tidak valid
  test "nama should be unique" do
    duplicate_author = @author.dup
    @author.save
    assert_not duplicate_author.valid?, "Author with duplicate nama should be invalid"
    assert_includes duplicate_author.errors[:nama], "sudah ada."
  end

  # Uji nama harus ada (tidak boleh kosong)
  test "nama should be present" do
    @author.nama = "   "
    assert_not @author.valid?, "Author is valid without a nama"
    assert_includes @author.errors[:nama], "can't be blank"
  end

  # Uji panjang nama
  test "nama should not be too short or too long" do
    @author.nama = "AB"
    assert_not @author.valid?, "Author is valid with a nama that is too short"
    assert_includes @author.errors[:nama], "harus lebih dari 3 karakter dan maksimal 100 karakter"

    @author.nama = "A" * 101
    assert_not @author.valid?, "Author is valid with a nama that is too long"
    assert_includes @author.errors[:nama], "harus lebih dari 3 karakter dan maksimal 100 karakter"
  end
end
