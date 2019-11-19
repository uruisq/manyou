class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    unless logged_in?
      @user = User.new
    else
      redirect_to root_path, notice: 'すでにログインしています。'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def confirm
    @user = User.new(user_params)
    @user.id = current_user.id
    render :new if @user.invalid?
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice:"user情報を編集しました！"
    else
      render :edit
    end
  end

  def show
    @tasks = @user.tasks
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

end