class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    User.where(id: session[:user_id]).first
  end
  helper_method :current_user

  def require_user
    unless current_user.present?
      respond_to do |format|
        format.html do
          flash[:error] = I18n.t('authentication.required')
          redirect_to root_path
        end

        format.js do
          render 'authentication_required'
        end
      end
    end
  end
end
