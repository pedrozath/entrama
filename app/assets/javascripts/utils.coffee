window.App = {}
App.hover_highlight = ->
    $(".hover-highlight").css transition: "opacity 250ms"
    $(".hover-highlight").on
        mouseenter: (e) -> 
            trigger_element = $(e.currentTarget)
            trigger_element.siblings().filter(".hover-highlight").css opacity: 0.3
            trigger_element.css opacity: 1

        mouseleave: (e) -> 
            trigger_element = $(e.currentTarget)
            trigger_element.siblings().filter(".hover-highlight").css opacity: 1

window.puts = (things) -> console.log things