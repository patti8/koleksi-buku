class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def create

  end

  private

    def book_params
      params.require(:book).permit(:judul, :tahun_terbit, :author_id)
    end

end
