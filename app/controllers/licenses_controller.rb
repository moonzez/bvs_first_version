class LicensesController < ApplicationController
  before_action :authorize_dbuser!

  def destroy
    @license = License.find(params[:id])
    @license.destroy
  end

  def index
    @license = License.new
    @licenses = License.all
  end

  def create
    @license = License.new(license_params)
    if @license.save
      flash[:notice] = @license.shortcut + ' wurde angelegt'
    else
      flash[:alert] = 'Lizenz wurde nicht angelegt: ' + @license.generate_errors_for_remote
    end
    redirect_to licenses_path
  end

  private

  def license_params
    params.require(:license).permit(:title, :shortcut)
  end
end
