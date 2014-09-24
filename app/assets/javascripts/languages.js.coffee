# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(->
  $('a#add_another_language').click(->
    url = "/languages/new?language=" + $('#files input').length
    $.get(url, 
      (data)->
        $('#files').append(data)
    )
  )
)
