class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]
  before_action :find_languages, only: [:new, :create, :edit, :update]
  before_action :find_roles, only: [:new, :create, :edit, :update]
  before_action :find_licenses, only: [:new, :create, :edit, :update]

  def home; end

  def index
    @selected_letter = params[:selected_letter] || '*'
    @users = User.ordered_by_name(@selected_letter)
    @all_letters = User.present_abc
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save_with_params(params[:roles], params[:languages], params[:licenses])
      redirect_to users_path, notice: "Nutzer #{ @user.full_name } wurde angelegt"
    else
      render :new
    end
  end

  def update
    if @user.update_with_params(user_params, params[:roles], params[:languages], params[:licenses])
      redirect_to users_path, notice: "Nutzerdaten für #{ @user.full_name } wurden geändert"
    else
      render :edit
    end
  end

  def destroy
    if @user.identic?(current_user)
      @user.errors.add(:base, 'Sie können eigenes Profil nicht löschen')
    else
      @user.destroy
    end
  end

  private

  def find_languages
    @languages = Language.all
  end

  def find_roles
    @roles = Role.all
  end

  def find_licenses
    @licenses = License.all
  end

  def user_params
    params.require(:user).permit(User.column_names.map(&:to_sym) - [:id] + [:password])
  end

  def find_user
    @user = User.find(params[:id])
  end
end
