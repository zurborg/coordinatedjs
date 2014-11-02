(->
	if !@moment?
		console?.error? 'moment.js not available'
	else
		servertime = moment('%UNIXTIME%', 'X')
		clienttime = moment()
		offset = moment(servertime).diff clienttime, 'seconds'
		@$moment = () ->
			moment().add 'seconds', offset
).call window
