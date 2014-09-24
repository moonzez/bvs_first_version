class LicensesController < ApplicationController

  def destroy
    @license = License.find(params[:id])
    if !@license.is_in_use
      @license.destroy
    else
      @license.errors.add(:base, t('is_in_use', :what => @license.title))
    end
  end

  def index
    @license = License.new
    @licenses = License.all
  end

  def create
    @license = License.new(license_params)
    if @license.save
      flash[:notice] = @license.shortcut + " wurde angelegt"
    else
      flash[:alert] = "Lizenz wurde nicht angelegt: " + @license.get_errors_for_remote
    end
    redirect_to licenses_path
  end

  private

  def license_params
    params.require(:license).permit(:title, :shortcut)
  end
end
