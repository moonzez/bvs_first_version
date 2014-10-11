class ProfileController < ApplicationController
  before_action :find_profile
  before_action :find_languages, only: [:edit, :update]
  before_action :find_roles, only: [:edit, :update]
  before_action :find_licenses, only: [:edit, :update]

  def edit
  end

  def update
    if @profile.update_myself(profile_params, params[:roles], params[:languages], params[:licenses])
      redirect_to root_path, notice: 'Ihr Profil wurde geändert'
    else
      render :edit
    end
  end

  private

  def find_profile
    @profile = User.find(params[:id])
    redirect_to root_path, alert: I18n.t('only_own_profile') unless @profile.identic?(current_user)
  end

  def find_languages
    @languages = Language.all
  end

  def find_roles
    @roles = Role.all
  end

  def find_licenses
    @licenses = License.all
  end

  def profile_params
    params.require(:profile).permit(User.column_names.map(&:to_sym) - [:id] + [:password])
  end
end
