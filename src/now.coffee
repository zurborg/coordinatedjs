(->
	if !@moment?
		console?.error? 'moment.js not available'
	else
		poffset = 0
		if window.performance?
			poffset -= (window.performance.now() / 1000)
		unixtime = parseFloat('%UNIXTIME%') * 1000;
		console.log "unixtime = #{unixtime}, poffset = #{poffset}"
		unixtime -= poffset
		servertime = moment(unixtime)
		clienttime = moment()
		offset = moment(servertime).diff clienttime, 'milliseconds'
		@$moment = () ->
			moment().add offset, 'milliseconds'
		@$moment.utc = () ->
			moment.utc().add offset, 'milliseconds'
		@$moment.offset = offset
).call window
