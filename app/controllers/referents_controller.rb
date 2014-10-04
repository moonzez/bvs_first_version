class ReferentsController < ApplicationController
  def index
    @selected_letter = params[:selected_letter] || '*'
    all_referents = User.referents
    @referents = all_referents.ordered_by_name(@selected_letter)
    @all_letters = all_referents.present_abc
  end
end
