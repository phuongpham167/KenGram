class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "users.logged_in_user.danger"
    redirect_to login_url
  end
end
