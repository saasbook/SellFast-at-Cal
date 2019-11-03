class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:username, :email)
  end

  def index
    @users = users.all
  end

  def new
    # default: render 'new' template
  end
  
  def create
 
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
