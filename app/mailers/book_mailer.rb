class BookMailer < ApplicationMailer
  def new_book_notification(user, book)
    @user = user
    @book = book
    mail(to: @user.email, subject: "Kamu berhasil menambahkan buku #{@book.judul}")
  end
end
