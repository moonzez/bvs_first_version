class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  helper_method :current_user, :admin?, :dbuser?, :reader?, :accounter?, :referent?

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @curent_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_login
    redirect_to login_url unless current_user
  end

  %w(admin dbuser reader accounter referent).each do |role|
    define_method(role + '?') { current_user.roles.include?(Role.find_by(title: role)) }
  end

  def authorize_admin!
    redirect_to root_path, alert: I18n.t('only_admin') unless admin?
  end

  def authorize_dbuser!
    redirect_to root_path, alert: I18n.t('only_dbuser') unless admin? || dbuser?
  end

  def authorize_dbuser_or_accounter!
    redirect_to root_path, alert: I18n.t('only_dbuser_or_accounter') unless admin? || dbuser? || accounter?
  end
end
