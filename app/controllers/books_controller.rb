class BooksController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    @books = Book.paginate(page: params[:page], per_page: 8).order(created_at: :desc)
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      # BookMailerJob.perform_later(current_user, @book) if user_signed_in?

      BooksChannel.broadcast_new_book(@book)

      render json: { message: "Buku berhasil ditambahkan.", book: @book }, status: :created
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def book_params
      params.require(:book).permit(:judul, :tahun_terbit, :author_id)
    end

end
