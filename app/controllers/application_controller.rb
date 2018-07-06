class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "users.logged_in_user.danger"
    redirect_to login_url
  end

  def not_found
    raise ActiveRecord::RecordNotFound, t(:not_found)
  rescue StandardError
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
