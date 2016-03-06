#= require jquery
#= require jquery_ujs
#= require mustache.min
#= require turbolinks
#= require editable

class ProductCRUD
    constructor: (options) ->
        for key, value of options 
            this[key] = options[key]

        @data = @main_element.data()
        for key, value of @data
            this[key] = @data[key]

        @template = $(".product-crud").html()

        a = $.get "/products.json", {}, (data) =>
            console.log data
            # console.log "teste"
            # @crud_data = data
            # @refresh()
        # a.always ->

    refresh: =>
        render = Mustache.render(@template, @crud_data)
        @main_element.html render

    create: =>
        @refresh()

$ ->
    $("[data-editable]").each -> new Editable element: $(this)
    $(".product-crud").each -> new ProductCRUD main_element: $(this)
