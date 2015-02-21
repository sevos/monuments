class UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = I18n.t('users.created')
      redirect_to users_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = I18n.t('users.deleted')
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:login, :password, :password_confirmation)
  end
end
