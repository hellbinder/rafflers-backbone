class Raffler.Views.Entry extends Backbone.View
 
  template: JST['entries/entry']
  tagName: 'li'
  events:
  	#no need to pass secondoptions since we are listening in on full element (wrapper)
  	'click': 'showEntry'
  initialize: -> 
  	@model.on('change',@render, this)
  	@model.on('highlight',@highlightWinner,this)

  render: ->
  	$(@el).attr('id','entry_' + @model.get('id')).html(@template(entry: @model))
  	this #Expected to return this view so it can be chained later. can also use @ (which is the same as this in coffeescript)

  highlightWinner: ->
  	$('.winner').removeClass('highlight')
  	@$('.winner').addClass('highlight') # We don’t want every one of these elements to be highlighted, only the one that’s inside this template and Backbone provides a nice way to do this by calling this.

  showEntry: ->
  	Backbone.history.navigate("entries/#{@model.get('id')}",true)
