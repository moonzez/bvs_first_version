module GuidedtoursHelper
  def find_out_special_class(tour)
    date_70 = Date.parse('2015-05-03')
    if tour.date1 == date_70 || tour.date2 == date_70 || tour.date3 == date_70
      'show_70_years'
    elsif tour.themetour
      'show_themetour'
    else
      ''
    end
  end
end
