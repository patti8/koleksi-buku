module BooksApi
  class Base < Grape::API

    format :json

    resource :books do

      desc 'Tambahkan Buku Baru'
      params do
        requires :judul, type: String, desc: 'The title of the book'
        requires :tahun_terbit, type: String, desc: 'The genre of the book'
        requires :author_id, type: Integer, desc: 'The ID of the author'
      end
      post do
        # Create the book with the provided parameters
        book = Book.new({
          juul: params[:judul],
          genre: params[:tahun_terbit],
          author_id: params[:author_id]
        })

        if book.save
          { status: 'success', book: book }
        else
          error!({ status: 'failure', errors: book.errors.full_messages }, 422)
        end
      end

      desc 'lihat semua buku'
      get do
        books = Book.includes(:author).all

        # Transform books into a format that includes author information
        result = books.map do |book|
          {
            id: book.id,
            juul: book.judul,
            tahun_terbit: book.tahun_terbit,
            author: {
              id: book.author.id,
              name: book.author.nama
            }
          }
        end

        { status: 'success', books: result }
      end
    end
  end
end
