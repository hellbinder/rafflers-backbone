class Raffler.Views.EntriesShow extends	Backbone.View

	template: JST['entries/show']
	events:
		'click #lnkToMain':'redirectToMain'

	render: ->
		$(@el).html(@template(entry: @collection))
		this

	redirectToMain: (e) ->
		e.preventDefault()
		Backbone.history.navigate('/',true)