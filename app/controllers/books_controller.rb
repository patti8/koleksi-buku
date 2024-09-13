class BooksController < ApplicationController
  before_action :authenticate_user!, only: :create
  protect_from_forgery with: :null_session

  def index
    @books = Book.includes(:author).order(created_at: :desc)

    if params[:show_all].present? && params[:show_all] == 'true'
      @books = @books.all
    else
      @books = @books.paginate(page: params[:page], per_page: params[:per_page] || 8)

      @books = @books.where("judul LIKE ?", "%#{params[:judul]}%") if params[:judul].present?
      @books = @books.where(tahun_terbit: params[:tahun_terbit]) if params[:tahun_terbit].present?
      @books = @books.joins(:author).where(author: { nama: params[:nama_penerbit] }) if params[:nama_penerbit].present?
    end

    respond_to do |format|
      format.html
      format.json do
        render json: {
          books: @books.as_json(include: [:author]),
          total_data: @books.size,
          total_pages: (@books.respond_to?(:total_pages) ? @books.total_pages : 1),
          current_page: (@books.respond_to?(:current_page) ? @books.current_page : 1)
        }, status: :ok
      end
    end
  end



  def create
    @book = Book.new(book_params)
    if @book.save

      BookCreatedJob.perform_async(current_user.id, @book.id)
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
