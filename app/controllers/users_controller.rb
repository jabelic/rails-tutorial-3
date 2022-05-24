class UsersController < ApplicationController
private
  def user_params
    # admin権限は変更できないようにしている。
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  # # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location # アクセスしようとしたpathを覚えておく
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

public
  # before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy] # login user は
  before_action :correct_user,   only: [:edit, :update] # 正しいユーザーかどうか
  before_action :admin_user,     only: :destroy
  # indexはログインユーザーのみアクセス可能
  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end
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
  
  # Delete
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
end
