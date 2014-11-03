(->
	if !@moment?
		console?.error? 'moment.js not available'
	else
		clienttime = moment()
		if window.performance?.timing?.navigationStart?
			clienttime = moment(window.performance.timing.navigationStart)
		servertime = moment(parseFloat('%UNIXTIME%') * 1000)
		offset = moment(servertime).diff clienttime, 'milliseconds'
		@$moment = () ->
			moment().add offset, 'milliseconds'
		@$moment.utc = () ->
			moment.utc().add offset, 'milliseconds'
		@$moment.offset = offset
).call window
