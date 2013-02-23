class Raffler.Routers.Entries extends Backbone.Router
	routes:
		'': 'index'
		'entries/:id': 'show'
	initialize: ->
		@collection = new Raffler.Collections.Entries()
		@collection.reset($('#container').data('entries'))
	
	index: -> 
		view = new Raffler.Views.EntriesIndex(collection: @collection)
		$('#container').html(view.render().el)

	show: (id) ->
		selectedEntry = @collection.get(id)
		console.log(selectedEntry.attributes)
		view = new Raffler.Views.EntriesShow(collection: selectedEntry.attributes) #collection used to send model you are going to work with.
		$('#container').html(view.render().el)