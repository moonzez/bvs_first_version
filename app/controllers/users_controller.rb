class UsersController < ApplicationController

  before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_action :get_languages, only: [:new, :create, :edit, :update, :show]
  before_action :get_roles, only: [:new, :create, :edit, :update, :show]

  def home; end

  def index
    @selected_letter = params[:selected_letter] || "*"
    @users = User.ordered_by_name(@selected_letter)
    @all_letters = User.present_abc
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.check_referent(params[:roles]) and @user.save
      @user.assign_roles(params[:roles])
      @user.assign_languages(params[:languages])
      redirect_to users_path, notice: "Nutzer #{ @user.full_name } wurde angelegt"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      @user.assign_roles(params[:roles])
      @user.assign_languages(params[:languages])
      redirect_to users_path, notice: "Nutzerdaten für #{ @user.full_name } wurden geändert"
    else
      render :edit
    end
  end

  def destroy
    if current_user == @user
      flash[:alert] = "Sie können eigenes Profil nicht löschen"
    elsif @user.can_be_removed
      @user.destroy
      flash[:notice] = 'Nutzer wurde gelöscht'
    else
      flash[:alert] = "#{ @user.full_name } darf nicht gelöscht werden"
    end
    redirect_to users_path
  end

  private

    def get_languages
      @languages = Language.all
    end

    def get_roles
      @roles = Role.all
    end

    def user_params
      params.require(:user).permit(User.column_names.map { |attr| attr.to_sym } -[:id] + [:password])
    end

    def get_user
      @user = User.find(params[:id])
    end
end
