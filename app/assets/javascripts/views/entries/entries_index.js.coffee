class Raffler.Views.EntriesIndex extends Backbone.View
 
  template: JST['entries/index']
  #EVENTS ARE HANDLES IN THE VIEWS (Read documentation for more info)
  events:
  	'submit #new_entry': 'create_entry'
  	'click a': 'delete_entry'
  	'submit #draw_winner': 'draw_winner'

  initialize: ->
  	@collection.on('reset', @render, this)
  	@collection.on('add', @appendEntry, this) #renders view again when entry created.
  	@collection.on('remove', @removeEntry, this)

  render: ->
  	# $(@el).html(@template(entries: @collection)) <-- BEFORE!
  	$(@el).html(@template())
  	@collection.each(@appendEntry)
  	this #Expected to return this view so it can be chained later. can also use @ (which is the same as this in coffeescript)
  
  appendEntry: (entry) ->
  	view = new Raffler.Views.Entry(model: entry)
  	$('#entries').append(view.render().el)

  removeEntry: (entry) ->
  	$('#entry_'+ entry.get('id'))
  	.css('background-color','red')
  	.fadeOut(1000, ->
  		@.remove())

  create_entry: (event) -> 
  	event.preventDefault()
  	#won't refresh the view but it will save the entry
  	@collection.create name: $('#new_entry_name').val()

  delete_entry: (e) ->
  	e.preventDefault()
  	currentEntryLi = $(e.currentTarget)
  	currentEntry = currentEntryLi.parent().text().trim()
  	id = currentEntryLi.data("id")
  	@collection.get(id).destroy() if confirm  "Are you  sure you want to delete #{currentEntry}?"

  draw_winner: (e) ->
  	e.preventDefault()
  	random_winner = _(@collection.models.filter (model) ->
  		model.attributes.winner is null).shuffle()
  	random_winner[0].set('winner': true)
  	random_winner[0].save()
  	alert "The winner is #{random_winner[0].attributes.name}"
