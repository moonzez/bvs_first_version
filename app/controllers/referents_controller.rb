class ReferentsController < ApplicationController

  def index
    @selected_letter = params[:selected_letter] || "*"
    @referents = User.referents.ordered_by_name(@selected_letter)
    @all_letters = User.present_abc
  end

end
