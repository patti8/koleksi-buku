class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def new_book_email(user, book)
    @user = user
    @book = book
    mail(to: @user.email, subject: 'Buku Baru Ditambahkan!')
  end
end
