$(->
  $.extend jQuery.fn.dataTableExt.oSort,
    'de_date-asc': (a, b) ->
      x = undefined
      y = undefined
      if $.trim(a) isnt ''
        deDatea = $.trim(a).split('.')
        x = (deDatea[2] + deDatea[1] + deDatea[0]) * 1
      else
        x = Infinity
      if $.trim(b) isnt ''
        deDateb = $.trim(b).split('.')
        y = (deDateb[2] + deDateb[1] + deDateb[0]) * 1
      else
        y = Infinity
      z = ((if (x < y) then -1 else ((if (x > y) then 1 else 0))))
      z

    'de_date-desc': (a, b) ->
      x = undefined
      y = undefined
      if $.trim(a) isnt ''
        deDatea = $.trim(a).split('.')
        x = (deDatea[2] + deDatea[1] + deDatea[0]) * 1
      else
        x = Infinity
      if $.trim(b) isnt ''
        deDateb = $.trim(b).split('.')
        y = (deDateb[2] + deDateb[1] + deDateb[0]) * 1
      else
        y = Infinity
      z = ((if (x < y) then 1 else ((if (x > y) then -1 else 0))))
      z
)

@set_base_datatable = (table, not_orderable, date_sort = false) ->
  table.dataTable
    columnDefs: get_column_defs(not_orderable, date_sort)
    pagingType: 'full_numbers'
    scrollX: true
    jQueryUI: true
    order: [[ 0, 'asc' ]]
    language: de_translations()
    lengthMenu: [ [10, 20, 50, -1], [10, 20, 50, "Alle"] ]

@de_translations = ->
  return {
    sEmptyTable: 'Keine Daten in der Tabelle vorhanden',
    sInfo: '_START_ bis _END_ von _TOTAL_ Einträgen',
    sInfoEmpty: '0 bis 0 von 0 Einträgen',
    sInfoFiltered: '(gefiltert von _MAX_ Einträgen)',
    sLengthMenu: '_MENU_ Einträge anzeigen',
    sSearch: 'Suchen ',
    sZeroRecords: 'Keine Einträge vorhanden',
    oPaginate: {
      sFirst: 'Erste',
      sPrevious: 'Zurück',
      sNext: 'Nächste',
      sLast: 'Letzte'
    }
}

get_column_defs = (not_orderable, date_sort) ->
  defs = [ {
    targets: not_orderable
    orderable: false
  } ]
  defs.push({ type: 'de_date', targets: date_sort }) if date_sort
  return defs
