# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(-> set_base_datepicker('#guidedtour_date1'))
$(-> set_base_datepicker('#guidedtour_date2'))
$(-> set_base_datepicker('#guidedtour_date3'))
$(-> set_base_datepicker('#guidedtour_confirmed_date'))

$(-> $('#clear_1').click(-> reset_fields('1')))
$(-> $('#clear_2').click(-> reset_fields('2')))
$(-> $('#clear_3').click(-> reset_fields('3')))
$(-> $('#clear_confirmed').click(-> reset_fields('confirmed')))

reset_fields = (number_str) ->
  if number_str == 'confirmed'
    $('#guidedtour_confirmed_date').val('')
    $('#guidedtour_confirmed_from').val('')
    $('#guidedtour_confirmed_to').val('')
  else
    $('#guidedtour_date' + number_str).val('')
    $('#guidedtour_from' + number_str).val('')
    $('#guidedtour_to' + number_str).val('')

$(-> $('#guidedtour_from1').change(-> set_to(this.value, '1')))
$(-> $('#guidedtour_from2').change(-> set_to(this.value, '2')))
$(-> $('#guidedtour_from3').change(-> set_to(this.value, '3')))
$(-> $('#guidedtour_confirmed_from').change(-> set_to(this.value, 'confirmed')))

set_to = (from, number_str) ->
  to = if from != '' then add_minutes(from) else ''
  if number_str == 'confirmed'
    $('#guidedtour_confirmed_to').val(to)
  else
    $('#guidedtour_to' + number_str).val(to)

$(-> $('#guidedtour_participants').change(->check_is_numeric(this)))
$(-> $('#guidedtour_male_count').change(->check_is_numeric(this)))
$(-> $('#guidedtour_female_count').change(->check_is_numeric(this)))
$(-> $('#guidedtour_teamleader').change(->check_is_numeric(this)))

check_is_numeric = (obj) ->
  value = obj.value
  if value != '' && !$.isNumeric(value)
    obj.value = ''
    alert('Dieses Feld darf nur Zahlen enthalten.')

$(-> set_base_datatable($('#opened_guidedtours'), opened_tours_not_orderable(), [0, 3]))

opened_tours_not_orderable = ->
  th_count = $('#opened_guidedtours thead tr:last th').length
  return if (th_count == 8) then [ 15, 16, 17] else [15, 16]

$(-> $('#guidedtour_take_date1').mouseout(->
  this.src='/assets/date.png'
).mouseover(->
  this.src='/assets/date_mouseover.png'
).click(->
  set_confirmed_date('1')
))

$(-> $('#guidedtour_take_date2').mouseout(->
  this.src='/assets/date.png'
).mouseover(->
  this.src='/assets/date_mouseover.png'
).click(->
  set_confirmed_date('2')
))

$(-> $('#guidedtour_take_date3').mouseout(->
  this.src='/assets/date.png'
).mouseover(->
  this.src='/assets/date_mouseover.png'
).click(->
  set_confirmed_date('3')
))

set_confirmed_date = (date_nr) ->
  date = $('#guidedtour_date' + date_nr).val()
  from = $('#guidedtour_from' + date_nr).val()
  to = $('#guidedtour_to' + date_nr).val()

  $('#guidedtour_confirmed_date').val(date)
  $('#guidedtour_confirmed_from').val(from)
  $('#guidedtour_confirmed_to').val(to)
