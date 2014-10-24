# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(-> set_base_datepicker('#guidedtour_date1'))
$(-> set_base_datepicker('#guidedtour_date2'))
$(-> set_base_datepicker('#guidedtour_date3'))

$(-> $('#clear_1').click(-> reset_fields('1')))
$(-> $('#clear_2').click(-> reset_fields('2')))
$(-> $('#clear_3').click(-> reset_fields('3')))

reset_fields = (number_str) ->
  $('#guidedtour_date' + number_str).val('')
  $('#guidedtour_from' + number_str).val('')
  $('#guidedtour_to' + number_str).val('')

$(-> $('#guidedtour_from1').change(-> set_to(this.value, '1')))
$(-> $('#guidedtour_from2').change(-> set_to(this.value, '2')))
$(-> $('#guidedtour_from3').change(-> set_to(this.value, '3')))

set_to = (from, number_str) ->
  to = if from != '' then add_minutes(from) else ''
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
