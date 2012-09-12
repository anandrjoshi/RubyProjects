class UserSearchController < ApplicationController

def search
     @users = User.search(params[:first_name], params[:last_name])
  end

end
