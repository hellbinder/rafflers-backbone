class Raffler.Views.EntriesIndex extends Backbone.View
 
  template: JST['entries/index']
  #EVENTS ARE HANDLES IN THE VIEWS (Read documentation for more info)
  events:
  	'submit #new_entry': 'create_entry'
  	'click a': 'delete_entry'
  	'click #draw': 'draw_winner'

  initialize: ->
  	@collection.on('reset', @render, this)
  	@collection.on('add', @appendEntry, this) #renders view again when entry created.
  	@collection.on('remove', @removeEntry, this)

  render: ->
  	# $(@el).html(@template(entries: @collection)) <-- BEFORE!
  	$(@el).html(@template())
  	@collection.each(@appendEntry)
  	this #Expected to return this view so it can be chained later. can also use @ (which is the same as this in coffeescript)
  
  appendEntry: (entry) => #done because 'this or @' wont have the correct context. (the one passed by the referenced function)
  	view = new Raffler.Views.Entry(model: entry)
  	@$('#entries').append(view.render().el) 
    
    #After we render the template we call @collection.each and append the view for #
    #each entry to the #entries list element. The problem is that this list element 
    #doesn’t exist yet on the page since this now happens immediately when the view 
    #is created and rendered but not yet added to the container on the page. 
    #To fix this we need to change the way we access the list of entries and make 
    #sure that we always go through this view by using @ so the the code looks 
    #for the entries element within the view’s element and not on the page directly.

  removeEntry: (entry) ->
  	$('#entry_'+ entry.get('id'))
  	.css('background-color','red')
  	.fadeOut(1000, ->
  		@.remove())

  create_entry: (event) -> 
    event.preventDefault()
    #won't refresh the view but it will save the entry
    attributes = name: $('#new_entry_name').val()
    @collection.create attributes,
      wait: true #It still creates the entry (client). Doesn't wait for the server to respond. This helps.
      success: -> $("#new_entry")[0].reset()
      error: @handleError

  handleError: (entry, response)->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  delete_entry: (e) ->
  	e.preventDefault()
  	currentEntryLi = $(e.currentTarget)
  	currentEntry = currentEntryLi.parent().text().trim()
  	id = currentEntryLi.data("id")
  	@collection.get(id).destroy() if confirm  "Are you  sure you want to delete #{currentEntry}?"

  draw_winner: (e) ->
    e.preventDefault()
    @collection.drawWinner()