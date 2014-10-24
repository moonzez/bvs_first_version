@add_minutes = (from) ->
  hours_minutes = from.split(':')
  some_date = new Date(0, 0, 0, hours_minutes[0], hours_minutes[1])
  some_date.setMinutes(some_date.getMinutes() + 150)
  new_to = some_date.getHours().toString() + ':' + some_date.getMinutes().toString()
  new_to = new_to + '0' if new_to.length == 4
  return new_to

@set_base_datepicker = (identifier) ->
  $(identifier).datepicker(
    dateFormat: 'yy-mm-dd',
    showButtonPanel: true,
    changeMonth: true,
    changeYear: true,
    minDate: -0,
    maxDate: + 1825
    $.datepicker.regional['de']
  )
