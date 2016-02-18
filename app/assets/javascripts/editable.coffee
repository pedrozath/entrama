class Editable
	constructor: (options) ->
		
		for key, value of options 
			this[key] = options[key]

		@data = @element.data()
		for key, value of @data
			this[key] = @data[key]

		@element.attr "contenteditable", "true"
		@bind_events()

	bind_events: ->
		@element.on "keyup", =>
			clearTimeout @save_timer
			@save_timer = setTimeout =>
				@save()
			, 1000

	save: ->
		# console.log("save")
		$.post "#{@path}",
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