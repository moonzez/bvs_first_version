class ReferentsController < ApplicationController
  before_action :authorize_dbuser_or_accounter!
  before_action :find_languages, only: [:new, :create, :edit, :update]
  before_action :find_licenses, only: [:new, :create, :edit, :update]
  before_action :find_referent, only: [:change_activ, :edit, :update, :remove]
  before_action :authorize_admin!, only: [:remove]

  def index
    @selected_letter = params[:selected_letter] || '*'
    all_referents = User.referents.all_except_inactiv
    @referents = all_referents.ordered_by_name(@selected_letter)
    @all_letters = all_referents.present_abc
  end

  def new
    @referent = User.new
  end

  def create
    @referent = User.new(referent_params)
    if @referent.save_referent_with_params(params[:languages], params[:licenses])
      redirect_to referents_path, notice: "Referent #{ @referent.full_name } wurde angelegt"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @referent.update_referent_with_params(referent_params, params[:languages], params[:licenses])
      redirect_to referents_path, notice: "Referentendaten für #{ @referent.full_name } wurden geändert"
    else
      render :edit
    end
  end

  def remove
    @referent.destroy
  end

  def change_activ
    new_state = params[:activ]
    @referent.change_activ(new_state)
  end

  def inactiv
    @selected_letter = params[:selected_letter] || '*'
    all_inactiv_referents = User.referents.inactiv
    @referents = all_inactiv_referents.ordered_by_name(@selected_letter)
    @all_letters = all_inactiv_referents.present_abc
  end

  private

  def find_languages
    @languages = Language.all
  end

  def find_licenses
    @licenses = License.all
  end

  def referent_params
    params.require(:referent).permit(User.column_names.map(&:to_sym) - [:id] + [:password])
  end

  def find_referent
    @referent = User.referents.find(params[:id])
  end
end
