class BookMailerJob < ApplicationJob
  queue_as :default

  def perform(user, book)
    UserMailer.new_book_email(user, book).deliver_now
  end
end
