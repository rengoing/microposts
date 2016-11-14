class UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :followings, :followers, :favorites]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @title = 'Micropost'
    @count = @user.microposts.count
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Updated your Profile"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  # フォローフォロワー表示機能
  def followings
    @title = "Followings"
    @users = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @users = @user.follower_users
    render 'show_follow'
  end
  
  # お気に入り表示機能
  def favorites
    @title = 'Favorites'
    @count = @user.favorite_microposts.count
    @microposts = @user.favorite_microposts
    render 'show'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :location)
  end
  
  def set_params
    @user = User.find(params[:id])
  end
  
  def correct_user
    redirect_to root_path if @user != current_user
  end
end
