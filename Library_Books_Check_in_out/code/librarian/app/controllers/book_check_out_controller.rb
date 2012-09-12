class BookCheckOutController < ApplicationController
def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

def check_out
	@user = User.find_by_first_name_and_last_name(params[:first_name].lstrip.rstrip.humanize, params[:last_name].lstrip.rstrip.humanize)
	if !@user.nil?
		@book = Book.find(params[:id])
		@book.users << @user
	else
		flash.now[:error] = "This user does not exist."
		redirect_to book_check_out_path, :notice => "This user does not exist."
	end
  end
end

