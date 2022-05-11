class UsersController < ApplicationController
  def new
  end
  def show
    # local変数は    hoge
    # instance変数は @hoge
    # grobal変数は   @@hoge
    @user = User.find(params[:id])
    # debugger
  end
end
