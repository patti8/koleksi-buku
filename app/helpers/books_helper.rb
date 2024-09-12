module BooksHelper

  def self.penulis
    Author.all.select(:nama)
  end

end
