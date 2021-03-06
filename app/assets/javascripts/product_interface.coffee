class ProductInterface
    constructor: (options) ->
        for key, value of options 
            this[key] = options[key]

        @selected_product = @main_element.attr "data-selected-product"
        @converted_to_template = false
        @bind_events()

        $(window).on "popstate", (e) => @change e.originalEvent.state

    bind_events: =>
        $(".products li").click (e) =>
            @select $(e.currentTarget).attr "data-icon-id"
            
        $("[data-select-size]").on "change", (e) =>
            @select $(e.currentTarget).val()

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
        @converted_to_template = true

    refresh: =>
        $.get "#{@path}/#{@selected_product}.json", (data) =>
            @convert_to_template() unless @converted_to_template
            @main_element.html Mustache.render(@template, data)
            $("[data-select-size]").filter("[value=\'#{@selected_product}\']").attr "checked", true
            @bind_events()
            @on_refresh() if @on_refresh?

    select: (id) =>
        window.history.pushState id, "", "#{id}"
        @change id 

    change: (id) => 
        @selected_product = id
        @refresh()

@ProductInterface = ProductInterface