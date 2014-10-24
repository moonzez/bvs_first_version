class GuidedtoursController < ApplicationController
  before_action :authorize_dbuser_or_accounter!

  def index; end

  def new
    @guidedtour = Guidedtour.new
  end

  def create
    @guidedtour = Guidedtour.new(guidedtour_params)
    if @guidedtour.save
      flash[:notice] = 'Geführter Rundgang wurde angelegt'
      redirect_to guidedtours_path
    else
      render :new
    end
  end

  private

  def guidedtour_params
    params.require(:guidedtour).permit(Guidedtour.permitted_params)
  end
end
