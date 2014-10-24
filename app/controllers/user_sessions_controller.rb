class UserSessionsController < ApplicationController
  skip_before_action :require_login
  before_action :logged_in?, only: :new

  def new
    @logged_in = UserSession.find ? true : false
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_path, notice: 'Sie sind angemeldet'
    else
      render :new
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to root_path, notice: 'Sie sind abgemeldet'
  end

  private

  def logged_in?
    redirect_to root_url, alert: 'Sie sind angemeldet' if current_user
  end
end
