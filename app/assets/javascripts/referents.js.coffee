$(->
  set_base_datatable($('#referents'), referents_not_orderable())
  set_base_datatable($('#inactiv_referents'), inactiv_referents_not_orderable())
)

referents_not_orderable = ->
  th_count = $('#referents thead tr:last th').length
  return if (th_count == 4) then [ 6, 9, 10, 11, 12] else [6, 9, 10, 11]

inactiv_referents_not_orderable = ->
  th_count = $('#inactiv_referents thead tr:last th').length
  return if (th_count == 3) then [ 7, 8, 9] else [7, 8]

$(->
  $('#mail_all').click(->
    selected = $('#mail_all').is(':checked')
    all_elements = $('[id^="mailto_"]')
    all_elements.prop('checked', selected)
  )
)

build_link = (emails, number) ->
  link = document.createElement('a')
  link.href = 'mailto:bildung@kz-gedenkstaette-dachau.de?bcc=' + emails
  link.innerHTML = 'Email an die ' + number + '. Gruppe der Referenten senden'
  $('div#chrome_links').append(link, '<br>')

workaround_mailto_chrom = (all_elements) ->
  $('div#chrome_links').replaceWith('<div id="chrome_links"></div>');
  bcc_arr = []
  count_links = 1
  for mailto_element in all_elements
    if bcc_arr.length >= 40
      build_link(bcc_arr.toString(), count_links)
      bcc_arr = []
      count_links++
    bcc_arr.push(mailto_element.value)
  if bcc_arr.length > 0
    build_link(bcc_arr.toString(), count_links)

  infotext = 'Da Chrome Browser das automatische Öffnen von multiplen Email- Fenster nicht erlaubt,
    haben wir für Sie Links generiert und diese am Anfang der Seite plaziert.
    Bitte klicken Sie diese Links um Emails an alle markierten Referenten zu senden.'
  alert(infotext)

open_mailto = (all_elements) ->
  bcc_arr = []
  for mailto_element in all_elements
    if bcc_arr.length >= 40
      location.href = 'mailto:bildung@kz-gedenkstaette-dachau.de?bcc=' + bcc_arr.toString()
      bcc_arr = []
    bcc_arr.push(mailto_element.value)

  if bcc_arr.length > 0
    location.href = 'mailto:bildung@kz-gedenkstaette-dachau.de?bcc=' + bcc_arr.toString()

$(->
  $('.multiple_mailto').click(->
    all_elements = $('[id^="mailto_"]:checked')
    if all_elements.length > 40 && (/chrome/i.test(navigator.userAgent))
      workaround_mailto_chrom(all_elements)
    else
      open_mailto(all_elements)
    return false
  )
)
