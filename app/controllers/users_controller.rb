class UsersController < ApplicationController
  include UsersHelper
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      redirect_to(user_url(User.find_by_screen_name(@user.screen_name)))
    end
  end
  
  def show
    @user = User.find(params[:id])
    save_user_tweets(@user)
    @tweets = @user.tweets
  end
  
  private
  def user_params
    params.require(:user).permit(:screen_name)
  end
  
end
