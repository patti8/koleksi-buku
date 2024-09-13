require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "valid@example.com", username: "validuser")
  end

  # Uji validasi email yang valid
  test "valid email addresses should be accepted" do
    valid_addresses = %w[tendy@example.com patti8@tim.go.id first.last@men.id ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # Uji validasi email yang tidak valid
  test "invalid email addresses should be rejected" do
    invalid_addresses = %w[tndy@example,com user_at_foo.id user.name@example. patti8@yu_hu.com tndy@tim+go.id yuhu@men..id]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # Uji email harus ada (tidak boleh kosong)
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?, "User is valid without an email"
    assert_includes @user.errors[:email], "can't be blank"
  end

  # Uji validasi format email menggunakan regex URI::MailTo::EMAIL_REGEXP
  test "email should match valid format" do
    @user.email = "invalid_email_format"
    assert_not @user.valid?, "User is valid with invalid email format"
    assert_includes @user.errors[:email], "is invalid"
  end
end
