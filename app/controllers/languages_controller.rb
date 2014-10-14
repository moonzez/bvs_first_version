class LanguagesController < ApplicationController
  before_action :authorize_dbuser!

  def destroy
    @language = Language.find(params[:id])
    @language.destroy
  end

  def index
    @language = Language.new
    @languages = Language.all
  end

  def create
    @language = Language.new(language_params)
    if @language.save
      flash[:notice] = @language.language + ' wurde angelegt'
    else
      flash[:alert] = 'Neue Sprache wurde nicht angelegt: ' + @language.generate_errors_for_remote
    end
    redirect_to languages_path
  end

  private

  def language_params
    params.require(:language).permit(:language)
  end
end
