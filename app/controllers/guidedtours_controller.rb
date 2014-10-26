class GuidedtoursController < ApplicationController
  before_action :authorize_dbuser_or_accounter!
  before_action :find_guidedtour, only: [:edit, :destroy, :update]

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

  def edit
  end

  def update
    flash[:notice] = 'Geführter Rundgang wurde geändert'
    redirect_to guidedtours_path
  end

  def destroy
    @guidedtour.destroy
  end

  def opened
    @opened_tours = Guidedtour.find_opened
  end

  private

  def guidedtour_params
    params.require(:guidedtour).permit(Guidedtour.permitted_params)
  end

  def find_guidedtour
    @guidedtour = Guidedtour.find(params[:id])
  end
end
