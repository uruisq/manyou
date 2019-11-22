class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page])
  end
  
  def show
    @tasks = @user.tasks.page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_url(@user), notice: 'Userを作成しました'
    else
      render :new
    end
  end

  def update
    unless @user.update(user_params)
      redirect_to admin_user_url(@user), notice: '更新できませんでした'
    else
      redirect_to admin_user_url(@user), notice: '更新しました'
    end
  end

  def destroy
    unless @user.destroy
      redirect_to admin_users_url, notice: '削除できませんでした'
    else
      redirect_to admin_users_url, notice: '削除しました'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def require_admin
    raise Forbidden unless current_user.admin?
  end
end
