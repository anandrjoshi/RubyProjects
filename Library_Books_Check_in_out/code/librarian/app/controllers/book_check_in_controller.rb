class BookCheckInController < ApplicationController
def show
    @book = Book.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

def check_in
	@book = Book.find(params[:id])
	@book.users.delete(User.find(@book.users[0].id))
  end
end
