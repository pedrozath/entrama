class ArtManager
    constructor: (options) ->
        for key, value of options 
            this[key] = options[key]

        @arts = @main_element.find "li"
        @actual = @main_element.find(".actual").first().find "img"
        @collection_id = @main_element.attr "data-collection-id"
        @bind_events()

    bind_events: =>
        @arts.click (e) => @select $(e.currentTarget)
        @arts.find(".small-btn").click (e) => 
            e.preventDefault()
            e.stopPropagation()
            @destroy $(e.currentTarget)

        @main_element.find("input[type=\"file\"]").change (e) => 

            @new_file e.currentTarget.files[0]
        
    select: (art_element) =>
        @arts.removeAttr "data-selected-art"
        art_element.attr "data-selected-art", "true"
        @actual.attr "src", art_element.find("img").first().attr "src"
        @main_element.find("code").remove()
        $.ajax
            url: "/collections/#{@collection_id}"
            method: "put"
            data:  
                field: "art"
                value: art_element.attr "data-art-id"

    destroy: (delete_btn) =>
        art = delete_btn.parent()
        $.ajax
            url: delete_btn.attr("href"),
            method: "delete"
            data: 
                id: art.attr "data-art-id"

        art.remove()

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

@ArtManager = ArtManager