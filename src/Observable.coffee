Observable = ->
	@observerList = []

	@notifyObservers = (context) ->

		for observer in @observerList
			if observer?
				observer.update(context)
