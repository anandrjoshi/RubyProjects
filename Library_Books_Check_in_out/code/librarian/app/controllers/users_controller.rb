class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all
	@user = User.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
	params[:user][:first_name] = params[:user][:first_name].lstrip.rstrip.humanize
	params[:user][:last_name] = params[:user][:last_name].lstrip.rstrip.humanize
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.js
		format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.js { render :action => 'create_error' }
		format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
	params[:user][:first_name] = params[:user][:first_name].lstrip.rstrip.humanize
	params[:user][:last_name] = params[:user][:last_name].lstrip.rstrip.humanize
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    respond_to do |format|
     if @user.books.length == 0
      @user.destroy
        format.html { redirect_to(users_url, :notice => 'User was successfully deleted.')  }
		format.js
        format.xml  { head :ok }
      
     else
		@user.errors.add(:books, "This user has checked out one or more books and so cannot be deleted.")
		format.html { redirect_to(@user, :id => @user.id, :notice => 'This user has checked out one or more books and so cannot be deleted.') }
		format.js { render :action => 'delete_error'}
    end
   end
  end
end
