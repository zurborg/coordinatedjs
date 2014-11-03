apply = (func) -> (obj, args...) -> func.apply(obj, args)
myformat = 'dddd, MMMM Do YYYY, hh:mm:ss'
window.jQuery $ ->
	jQ = (sel, func) -> func.call $(sel), $
	func = ->
		jQ '.server-time', ->
			@text $moment().format myformat
		jQ '.client-time', ->
			@text moment().format myformat
		jQ '.utc-time', ->
			@text $moment.utc().format myformat
	func()
	jQ '.offset-time', ->
		@text $moment.offset
	window.setInterval func, 1000
