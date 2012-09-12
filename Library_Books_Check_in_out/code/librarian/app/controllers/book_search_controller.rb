class BookSearchController < ApplicationController
def search
     @books = Book.search(params[:title])
  end

end
