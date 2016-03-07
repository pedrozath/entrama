#= require jquery
#= require jquery_ujs
#= require mustache.min
#= require turbolinks

class ProductCRUD
    constructor: (options) ->
        for key, value of options 
            this[key] = options[key]

        @data = @main_element.data()
        for key, value of @data
            this[key] = @data[key]

        @template = @main_element.find(".template").html()
        @read()

    bind_events: =>
        @main_element.find("[data-crud=\"update\"]").each (index, field) =>
            field = $(field)
            field.on "keyup", =>
                clearTimeout @save_timer
                @save_timer = setTimeout =>
                    @update(field)
                , 1000

            field.attr "contenteditable", "true"

        $("[data-crud=\"new\"]").on "click", => @create()
        $("[data-crud=\"destroy\"]").on "click", (e) => 
            e.preventDefault()
            @destroy($(e.currentTarget).attr("data-path"))

    create: => 
        $.post "/products.js", 
            product:
                garb_type: "Camiseta"
                fabric: "Algodão"
        , =>
            console.log "created"
            @read()

    read: => 
        $.get "/products.json", {}, (data) =>
            @crud_data = { produtos: data }
            @main_element.html Mustache.render @template, @crud_data
            @bind_events()

    update: (field) =>
        $.post field.attr("data-path")+".json",
            field: field.attr("data-field")
            value: field.html()
            _method: "put"
        , =>
            color = field.css "color"
            field.css color: "#f00"
            setTimeout =>
                field.css color: color
            , 200
            @read()

    destroy: (path) =>
        if confirm("Tem certeza que quer apagar esse produto lindinha?")
            $.post path+".json", _method: "delete", => @read()

$ -> $(".product-crud").each -> new ProductCRUD main_element: $(this)