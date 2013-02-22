window.Raffler =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
  	new Raffler.Routers.Entries()
  	Backbone.history.start()


$(document).ready ->
	$('li').on 'click',  ->
      $(@).hide()
	Raffler.initialize()
	

