class SessionsController < ApplicationController
  def create
    if user && user.authenticate(params[:password])
      @success = true
      session[:user_id] = user.id
    else
      @success = false
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def user
    @user ||= User.find_by_login(params[:login])
  end
end
