class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def create

  end

end
