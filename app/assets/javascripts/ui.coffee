$ ->
  $("[data-show-on-focus]").each ->
    $("##{$(@).data("show-on-focus")}").focus =>
      $(@).slideDown "fast"
    .blur =>
      $(@).slideUp "fast"
