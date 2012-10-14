$ ->
  if $("#search-field").length
    $("#search-field").focus()

  $(".categories-list h3 a").click (e) ->
    cat = $(@).closest('section')
    $('section').not(cat).hide(200)
    $('.all-back').show(200)
    # cat.show()
    false
  $(".all-back").click ->
    $('section').show(200)
    $(@).hide(200)
    false
