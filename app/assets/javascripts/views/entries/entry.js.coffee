class Raffler.Views.Entry extends Backbone.View
 
  template: JST['entries/entry']
  tagName: 'li'
  render: ->
  	$(@el).attr('id','entry_' + @model.get('id')).html(@template(entry: @model))
  	this #Expected to return this view so it can be chained later. can also use @ (which is the same as this in coffeescript)
