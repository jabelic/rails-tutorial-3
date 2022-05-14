class UsersController < ApplicationController
private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
public
  before_action :logged_in_user, only: [:edit, :update]
  def show
    # local変数は    hoge
    # instance変数は @hoge
    # grobal変数は   @@hoge
    @user = User.find(params[:id])
    # debugger
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # signupと同時にlogin
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
end
