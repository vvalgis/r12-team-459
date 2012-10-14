$ ->
  $(".entry-destroy-link").live "ajax:success", ->
    $(@).closest(".entry").slideUp "fast"


  if $("#search-field").length
    searchfieldTimeout = ""
    lastQuery = ""
    field = $("#search-field")
    searchResults = $("#search-results")
    searchResultsTemplate = $(".search-result-template").html()
    hash = unescape(window.location.hash).replace /\#/, ''
    loadCategories = ->
      hash = {}
      $.getJSON "/categories.json", (data) ->
        $.each data, ->
          hash[@.id] = @
      hash
    categories = loadCategories()


    $("#search-form").bind "ajax:before", ->
      if 0 == field.val().length
        $("#search-results-container").slideUp "fast"
        $("#new-entry-container").slideUp "fast"
        document.location.hash = ""
        return false
      document.location.hash = escape field.val()
      field.addClass "loading"
    .bind "ajax:success", (xhr, data, status) ->
      if "link" == data.type and 404 == data.status
        $("#search-results-container").slideUp "fast"
        $("#entry-url").val data.content.url
        $("#entry-title").val data.content.title
        $("#new-entry-form input[type=radio][value='#{data.content.type}']").click()

        $("#new-entry-container").slideDown "slow"
      if "results" == data.type and 200 == data.status
        $("#new-entry-container").slideUp "slow"
        $("#search-results-container").slideDown "fast"
        searchResults.slideUp("fast").html ""

        if 0 < data.content.length
          $("#nothing-found").slideUp "fast"
          $.each data.content, ->
            result = $(searchResultsTemplate)
            result.find(".title a.url").attr("href", @.url).html @.title
            result.find(".title a.close").attr "href", "/entries/#{@.id}"
            result.find(".description").html @.description
            if 0 < @.category_ids.length
              cats = []
              $.each @.category_ids, ->
                cats.push categories[@].name

              result.find(".categories").html cats.join(", ")
            else
              result.find(".categories").remove()
            result.appendTo searchResults
          searchResults.slideDown "fast"
        else
          $("#nothing-found").slideDown "fast"
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
      categories = loadCategories()
      $(@).fadeTo(500, 1)
      $("#new-entry-container").slideUp "slow"
      $("#search-field").val("").closest("form").submit()

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
