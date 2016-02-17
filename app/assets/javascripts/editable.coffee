class Editable
	constructor: (options) ->
		for key, value of options 
			this[key] = options[key]

		@element.attr "contenteditable", "true"
		@id = @element.data().id
		@field = @element.data().field
		@bind_events()

	bind_events: ->
		@element.on "keyup", =>
			clearTimeout @save_timer
			@save_timer = setTimeout =>
				@save()
			, 1000

	save: ->
		console.log("save")
		$.post "/products/#{@id}",
			field: @field
			value: @element.html()
			_method: "put"
			success: =>
				color = @element.css "color"
				@element.css color: "#f00"
				setTimeout =>
					@element.css color: color
				, 200

@Editable = Editable