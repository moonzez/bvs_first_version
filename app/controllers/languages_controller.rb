class LanguagesController < ApplicationController

  def destroy
    @language = Language.find(params[:id])
    if !@language.is_in_use
      @language.destroy
    else
      @language.errors.add(:base, t('is_in_use', :what => @language.language))
    end
  end

  def index
    @language = Language.new
    @languages = Language.all
  end

  def create
    @language = Language.new(language_params)
    if @language.save
      flash[:notice] = @language.language + " wurde angelegt"
    else
      flash[:alert] = "Neue Sprache wurde nicht angelegt: " + @language.get_errors_for_remote
    end
    redirect_to languages_path
  end

  private

  def language_params
    params.require(:language).permit(:language)
  end

end
