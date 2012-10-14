$ ->
  if $("#search-field").length
    searchfieldTimeout = ""
    lastQuery = ""
    field = $("#search-field")
    hash = unescape(window.location.hash).replace /\#/, ''

    $("#search-form").bind "ajax:before", ->
      document.location.hash = escape field.val()
      field.addClass "loading"
    .bind "ajax:success", (xhr, data, status) ->
      if "link" == data.type and 404 == data.status
        $("#entry-url").val data.content.url
        console.log "#search-form input[type=radio][value='#{data.content.type}']"
        $("#new-entry-form input[type=radio][value='#{data.content.type}']").click()

        $("#new-entry-container").slideDown "slow", ->
          $(@).find("input[type=text]")[0].focus()
    .bind "ajax:complete", ->
      $("#search-field").removeClass "loading"

    field.focus().keyup ->
      if lastQuery != $(this).val()
        clearTimeout searchfieldTimeout
        searchfieldTimeout = setTimeout ->
          lastQuery = field.val()
          field.closest("form").submit()
        , 500
    .keydown ->
      $(@).removeClass "loading"
      clearTimeout searchfieldTimeout

    $("#new-entry-form").bind "ajax:before", ->
      $(@).fadeTo(500, .3)
    .bind "ajax:complete", ->
      $(@).fadeTo(500, 1)
      $("#new-entry-container").slideUp "slow"

    if (hash.length > 0)
      field.val(hash).closest("form").submit()

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
