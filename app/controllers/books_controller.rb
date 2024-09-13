class BooksController < ApplicationController

  def index
    @books = Book.paginate(page: params[:page], per_page: 8)
  end

  def create
    render json: "yeay"
  end

  private

    def book_params
      params.require(:book).permit(:judul, :tahun_terbit, :author_id)
    end

end
