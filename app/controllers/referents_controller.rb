class ReferentsController < ApplicationController
  before_action :find_languages, only: [:new]
  before_action :find_referent, only: [:change_activ]

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
    if @referent.save_referent_with_params(params[:languages])
      redirect_to referents_path, notice: "Referent #{ @referent.full_name } wurde angelegt"
    else
      render :new
    end
  end

  def change_activ
    new_state = params[:activ]
    @referent.change_activ(new_state)
  end

  private

  def find_languages
    @languages = Language.all
  end

  def referent_params
    params.require(:referent).permit(User.column_names.map(&:to_sym) - [:id] + [:password])
  end

  def find_referent
    @referent = User.referents.find(params[:id])
  end
end
