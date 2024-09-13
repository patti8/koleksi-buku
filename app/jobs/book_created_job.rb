class BookCreatedJob
  include Sidekiq::Job

  def perform(user_id, book_id)
    user = User.find(user_id)
    book = Book.find(book_id)
    BookMailer.new_book_notification(user, book).deliver_later
  end
end
