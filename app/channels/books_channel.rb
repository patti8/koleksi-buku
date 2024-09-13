class BooksChannel < ApplicationCable::Channel
  def subscribed
    stream_from "books_channel"
  end

  def self.broadcast_new_book(book)
    ActionCable.server.broadcast("books_channel", {
      action: "create",
      book: {
        id: book.id,
        judul: book.judul,
        tahun_terbit: book.tahun_terbit,
        author: {
          id: book.author.id,
          nama: book.author.nama
        }
      }
    })
  end
end
