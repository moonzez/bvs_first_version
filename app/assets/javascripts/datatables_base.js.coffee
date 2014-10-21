@set_base_datatable = (table, not_orderable) ->
  table.dataTable
    columnDefs: [ {
      targets: not_orderable
      orderable: false
    } ]
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
