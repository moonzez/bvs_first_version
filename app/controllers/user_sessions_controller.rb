class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new
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
end
