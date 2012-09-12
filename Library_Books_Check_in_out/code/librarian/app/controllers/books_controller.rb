class BooksController < ApplicationController
  # GET /books
  # GET /books.xml
  def index
    @books = Book.all
	@book = Book.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
	params[:book][:title] = params[:book][:title].lstrip.rstrip.humanize
	params[:book][:publisher] = params[:book][:publisher].lstrip.rstrip.humanize
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to(@book, :notice => 'Book was successfully created.') }
        format.js
		format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.js { render :action => 'create_error' }
		format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
	params[:book][:title] = params[:book][:title].lstrip.rstrip.humanize
	params[:book][:publisher] = params[:book][:publisher].lstrip.rstrip.humanize
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    respond_to do |format|
     if @book.users.length == 0
      @book.destroy
        format.html { redirect_to(books_url, :notice => 'Book was successfully deleted.')  }
        format.js
		format.xml  { head :ok }
     else
		@book.errors.add(:users, "This book has been checked out and so cannot be deleted.")
		format.html { redirect_to(@book, :id => @book.id, :notice => 'This book has been checked out and so cannot be deleted.') }
		format.js { render :action => 'delete_error'}
    end
   end
  end
end
