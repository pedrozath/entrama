class IconManager
    constructor: (options) ->
        for key, value of options 
            this[key] = options[key]

        @icons = @main_element.find "li"
        @actual = @main_element.find(".actual").first().find "img"
        @product_id = @main_element.attr "data-product-id"
        @bind_events()

    bind_events: =>
        @icons.click (e) => @select $(e.currentTarget)
        @icons.find(".small-btn").click (e) => 
            e.preventDefault()
            e.stopPropagation()
            @destroy $(e.currentTarget)

        @main_element.find("input[type=\"file\"]").change (e) => 

            @new_file e.currentTarget.files[0]
        
    select: (icon_element) =>
        @icons.removeAttr "data-selected-icon"
        icon_element.attr "data-selected-icon", "true"
        @actual.attr "src", icon_element.find("img").first().attr "src"
        @main_element.find("code").remove()
        $.ajax
            url: "/products/#{@product_id}"
            method: "put"
            data:  
                field: "icon"
                value: icon_element.attr "data-icon-id"

    destroy: (delete_btn) =>
        icon = delete_btn.parent()
        $.ajax
            url: delete_btn.attr("href"),
            method: "delete"
            data: 
                id: icon.attr "data-icon-id"

        icon.remove()

    new_file: (file) =>
        console.log file
        fd = new FormData
        fd.append "file", file, file.name
        fd.append "event_id", @event_id
        console.log fd, @event_id
        request = $.ajax
            url: "/images/"
            data: fd
            processData: false
            contentType: false
            type: "POST"

        request.success =>
            @main_element.append "subindo imagem"
            location.reload()

@IconManager = IconManager