#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require editable

$ ->
    $("[data-editable]").each ->
        new Editable
            element: $(this)