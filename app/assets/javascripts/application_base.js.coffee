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

$(->
  $('#title_img').click(->
    $('#hidden_title').toggle()
    $(this).find('img').toggle()
    $('input#guidedtour_title').val('')
  )
)
@check_state_and_date = (event_name, state) ->
  if state == 'confirmed'
    date = $('#' + event_name + '_confirmed_date').val()
    from = $('#' + event_name + '_confirmed_from').val()
    to = $('#' + event_name + '_confirmed_to').val()

    if date == '' || from == '' || to == ''
      $('#' + event_name + '_state').val('opened')
      alert("Bevor Sie den Status auf 'bestätigt' setzen,
        geben Sie das Datum und die Uhrzeiten des bestätigten Termins ein!")
    else
      confirmed_date = new Date(Date.parse(date))
      current_date = new Date()
      if confirmed_date < current_date
        alert('Vorsicht! Das bestätigte Datum darf nicht in Vergangenheit liegen!')

@check_is_numeric = (obj) ->
  value = obj.value
  if value != '' && !$.isNumeric(value)
    obj.value = ''
    alert('Dieses Feld darf nur Zahlen enthalten.')

@prevent_empty_groupnumber = (event_name) ->
  groupnumber = $('#' + event_name + '_groupnumber')
  if groupnumber.val() == '' || groupnumber.val() == '0' || groupnumber.val() < 0
    groupnumber.val(1)

@check_patricipants_groupnumber = (event_name) ->
  err_text = 'Beachten Sie bitte: eine Gruppe besteht aus 30 Personen. Es wird empfohlen '
  participants = $('#' + event_name + '_participants').val()
  groupnumber = $('#' + event_name + '_groupnumber').val()

  should_be = Math.floor(participants / 30)

  if participants % 30 > 0
    should_be += 1
  if should_be > groupnumber
    err_text = err_text + should_be.toString()
    err_text = err_text + ' Gruppen zu bilden.'
    alert(err_text)

 @check_confirmed_date = (event_name) ->
   state = $('#' + event_name + '_state')
   console.log(state)
   confirmed_date = $('#' + event_name + '_confirmed_date').val()
   if state.val() == 'confirmed'
     if confirmed_date == ''
       alert("Bestätigtes Datum wurde gelöscht, Status wird auf 'offen' gesetzt!")
       state.val('opened')
     else
      check_state_and_date(event_name, 'confirmed')
