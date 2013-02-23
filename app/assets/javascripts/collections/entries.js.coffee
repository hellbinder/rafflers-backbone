class Raffler.Collections.Entries extends Backbone.Collection

  url: '/api/entries/'
  model: Raffler.Models.Entry

  drawWinner: ->
  	winner = _(@models.filter (model) ->
  		model.attributes.winner is not true).shuffle()[0]
  	winner.win() if winner
