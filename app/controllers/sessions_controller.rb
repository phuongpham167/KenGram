class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase || not_found
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember_user user
      redirect_to user
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def remember_user user
    remem = Settings.sessions.remember
    params[:session][:remember_me] == remem ? remember(user) : forget(user)
  end
end
