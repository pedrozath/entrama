#= require jquery
#= require jquery_ujs
#= require mustache.min
#= require turbolinks
#= require product_crud
#= require icon_manager

class ProductInterface
    constructor: (options) ->
        for key, value of options 
            this[key] = options[key]

        @selected_product = @main_element.attr "data-selected-product"
        @converted_to_template = false
        @bind_events()

    bind_events: =>
        $(".products li").click (e) =>
            @select $(e.currentTarget).attr "data-icon-id"
            @convert_to_template() unless @converted_to_template

    convert_to_template: =>
        @main_element.find("[data-template-attr]").each (index, element) =>
            element = $(element)
            eval "attributes = {"+element.attr("data-template-attr")+"}"
            for key,value of attributes
                element.attr key, value

        @main_element.find("[data-template-content]").each (index, element) =>
            element = $(element)
            element.html element.attr("data-template-content")

        @template = @main_element.html()
        @refresh()
        @converted_to_template = true


    refresh: =>
        $.get "/products/#{@selected_product}.json", (data) =>
            @main_element.html Mustache.render(@template, data)
            @bind_events()

    select: (id) =>
        @selected_product = id
        @refresh()

$ -> 
    $(".product-crud").each -> new ProductCRUD main_element: $(this)
    $("[data-icon-manager]").each -> new IconManager main_element: $(this)
    $("[data-product-interface]").each -> new ProductInterface main_element: $(this)