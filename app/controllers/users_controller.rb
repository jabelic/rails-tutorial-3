class UsersController < ApplicationController
private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
public
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
end
